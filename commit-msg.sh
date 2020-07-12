#!/bin/bash

COMMIT_MESSAGE_FILE=".git/COMMIT_EDITMSG"
COMMIT_MESSAGE_OUTPUT="grep -v '^#' ${COMMIT_MESSAGE_FILE}"
SUBJECT_LINE="${COMMIT_MESSAGE_OUTPUT} | awk 'NR==1'"
NEXT_SUBJECT_LINE="${COMMIT_MESSAGE_OUTPUT} | awk 'NR==2'"
START_BODY_LINE="${COMMIT_MESSAGE_OUTPUT} | awk 'NR==3'"
LAST_LINE="${COMMIT_MESSAGE_OUTPUT} | awk 'END {print}'"
LAST_SECOND_LINE="${COMMIT_MESSAGE_OUTPUT} | tail -2 | head -1"
END_BODY_LINE="${COMMIT_MESSAGE_OUTPUT} | tail -3 | head -1"


show-error() {
:<<DOC
    Shows error message in case of wrong commit message structure
DOC
    echo "Fail to commit changes!"
    echo ""
    echo "Possible reasons:"
    echo " - Subject commit starts from lower case letter"
    echo " - Subject commit starts from 'Merged' word"
    echo " - Subject commit doesn't contain at lease 3 words (only letters and digits allowed)"
    echo " - Next line after subject commit is not empty"
    echo " - Commit doesn't contain a body (should start from line 3)"
    echo " - Two or more empty lines after body commit (only one empty line is allowed)"
    echo " - Last line does not contain a issue task"
    echo ""
    echo "Commit message sample:"
    echo "Subject to be committed"
    echo ""
    echo "Body task description to be committed"
    echo ""
    echo "ISSUE-11"
    exit 1
}


validate-commit-message() {
:<<DOC
    Validates user commit message structure
DOC
    [[ `eval ${SUBJECT_LINE}` =~ ^[A-Z] ]] || show-error
    [[ `eval ${SUBJECT_LINE}` =~ [[:alnum:]]+[[:space:]][[:alnum:]]+[[:space:]][[:alnum:]].* ]] || show-error
    [[ `eval ${SUBJECT_LINE}` =~ ^Merged.* ]] && show-error
    [[ `eval ${NEXT_SUBJECT_LINE}` =~ ^$ ]] || show-error
    [[ `eval ${START_BODY_LINE}` =~ [[:alnum:]]+ ]] || show-error
    [[ `eval ${LAST_LINE}` =~ ISSUE-[[:digit:]]+ ]] || show-error
    [[ `eval ${LAST_SECOND_LINE}` =~ ^$ ]] || show-error
    [[ `eval ${END_BODY_LINE}` =~ [[:alnum:]]+ ]] || show-error
}


validate-commit-message
