# Dotfiles

```shell
cd ansible
uvx --from ansible-core ansible-galaxy install -r requirements.yml
uvx --from ansible-core ansible-playbook playbook_apps.yml -K
```