# Dotfiles

```shell
cd ansible
uvx --from ansible-core ansible-galaxy install -r requirements.yml
uvx --from ansible-core ansible-playbook playbook_apps.yml -K
```

## dev

```shell
# run playbook for quick try-outs
uvx --from ansible-core ansible-playbook playbook_tryout.yml -K
```
