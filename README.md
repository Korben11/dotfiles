# Dotfiles

```shell
cd ansible
# make suer uv is installed
curl -LsSf https://astral.sh/uv/install.sh | sh
uvx --from ansible-core ansible-galaxy install -r requirements.yml
uvx --from ansible-core ansible-playbook playbook_apps.yml -K
```

## dev

install git hooks:

    ./scripts/git/install-hooks.sh

```shell
# run playbook for quick try-outs
uvx --from ansible-core ansible-playbook playbook_dev.yml -K
```

```shell
# encrypt *.decrypted files
cd ansible
../scripts/ansible_encrypt.sh $PWD
```
