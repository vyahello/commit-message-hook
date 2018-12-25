#!/bin/bash

COMMIT_MSG_FILE=".git/COMMIT_EDITMSG"
COMMIT_MSG_OUTPUT="grep -v '^#' ${COMMIT_MSG_FILE}"
SUBJECT_LINE="${COMMIT_MSG_OUTPUT} | awk 'NR==1'"
NEXT_SUBJECT_LINE="${COMMIT_MSG_OUTPUT} | awk 'NR==2'"
START_BODY_LINE="${COMMIT_MSG_OUTPUT} | awk 'NR==3'"
LAST_LINE="${COMMIT_MSG_OUTPUT} | awk 'END {print}'"
LAST_SECOND_LINE="${COMMIT_MSG_OUTPUT} | tail -2 | head -1"
END_BODY_LINE="${COMMIT_MSG_OUTPUT} | tail -3 | head -1"


function error_msg {
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
    echo "Subject to be commited"
    echo ""
    echo "Body task description to be committed"
    echo ""
    echo "ISSUE-11"
    exit 1
}


function run_commit_msg_hook {
    [[ `eval ${SUBJECT_LINE}` =~ ^[A-Z] ]] || error_message
    [[ `eval ${SUBJECT_LINE}` =~ [[:alnum:]]+[[:space:]][[:alnum:]]+[[:space:]][[:alnum:]].* ]] || error_message
    [[ `eval ${SUBJECT_LINE}` =~ ^Merged.* ]] && error_message
    [[ `eval ${NEXT_SUBJECT_LINE}` =~ ^$ ]] || error_message
    [[ `eval ${START_BODY_LINE}` =~ [[:alnum:]]+ ]] || error_message
    [[ `eval ${LAST_LINE}` =~ ISSUE-[[:digit:]]+ ]] || error_message
    [[ `eval ${LAST_SECOND_LINE}` =~ ^$ ]] || error_message
    [[ `eval ${END_BODY_LINE}` =~ [[:alnum:]]+ ]] || error_message
}


run_commit_msg_hook
