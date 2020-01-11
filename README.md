Ansible provisionner for my servers
===================================

Install compact logger
----------------------

```
cd ..
git clone https://github.com/octplane/ansible_stdout_compact_logger.git
cd -
```


How to provision run script
---------------------------

Use tags to run provisioning :
```
ansible-playbook --ask-become-pass -i hosts -l home_server playbook.yml -t base
```

How to provision devm
---------------------

*From local network*

Just adapt the `hosts` file and run provisionning command.

*Using reverse SSH*

This section is a bit tricky because I want my home server to provision my work station, which is not public.
I assume that you already generate an ssh keypair for ansible. The private key is stored in `~/.ssh/id_INSECURE_DEVM_ANSIBLE_KEY` on home server.

First step, authorize access from home to devm :
```bash
sudo mkdir /root/.ssh && echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDaVxwV26kZMVIb+STHewTzG7HkxH3a2F9gygX8LbpzKluIKOO6b6rZ7AW+5MKE4RsLvfvJO10PuYQ3vWH2PQkq0FFZD+YO9qjx2hIJz7AKXIxM9WPfZkckXRV6rqbFhGuCFeZnwhxj0SgFvZ/bGXz/SyJoF+O9oaLWrq7Z77UiB34XMjmxM9/EeTQYEjEQB+cQEhio3LfCCqxMOiPhPREirlS/b69pvcU1pngh06w1Qvk2AuNbZo/uBZHDd2g5J4O2q1x9u8TyzgqJBZM1QFkGezVzNVC5bUUM5vbwzrgV3YgHDOSYwmJ2Gmv+jiUzn4O+4FsW5jUc47Kq8LtT9Pun ansible@unsecure-key" | sudo tee -a /root/.ssh/authorized_keys
```

On devm, open access to home :
```bash
ssh xavier@home -R 1922:localhost:22
```

You may need some conf in your .ssh/config :
```bash
Host home
	Hostname somepublicurl.net
	Port 22
	ForwardAgent yes
	IdentityFile ~/.ssh/id_cubi
	ProxyCommand /usr/bin/connect-proxy -H proxy.fr:3128 %h %p
```

On ansible server, you can now access to devm :
```bash
ssh -i $HOME/.ssh/id_INSECURE_DEVM_ANSIBLE_KEY root@127.0.0.1 -p 1922
```

You may now wan't to remove the key added in `/root/.ssh/authorized_keys`.

