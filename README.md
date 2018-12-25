# Commit message hook
A hook will allow you to create proper commit message including commit subject and body.

# Usage
Please move `commit-msg.sh` script into `.git/hooks` directory in the root of the current project.
```bash
mv commit-msg.sh .git/hooks
```

## Contributing

- clone the repository
- configure Git for the first time after cloning with your name and email
  ```bash
  git config --local user.name "Volodymyr Yahello"
  git config --local user.email "vyahello@gmail.com"
  ```
