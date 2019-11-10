# Commit message hook
A hook will **force** you to create proper commit message including commit _subject_ and _body_. No one line commits are allowed (body is required to fill in).

# Usage
Please move `commit-msg.sh` script into `.git/hooks` directory in the root of the current project.
```bash
mv commit-msg.sh .git/hooks
```

Then try to commit your changes. It will not allow you commit changes if:
  - Subject commit contains `Merge` word
  - Subject commit starts from lower case letter
  - Subject commit doesn't contain at least 3 words (only letters and digits allowed)
  - Commit doesn't contain a body (should start from line 3)
  - Last line does not contain a issue task

Commit sample

```bash
Commit message sample:
Subject to be commited

Body task description to be committed

ISSUE-11
```

## Contributing

- clone the repository
- configure Git for the first time after cloning with your name and email
  ```bash
  git config --local user.name "Volodymyr Yahello"
  git config --local user.email "vyahello@gmail.com"
  ```
