Ansible provisionner for my servers
===================================

How to provision run script
---------------------------

Use host and tag to run provisioning :
```
./configure.sh home base
```

How to provision devm
---------------------

*From local network*

Just adapt the `hosts` file and run provisionning command.

*From remote location*

This section is a bit tricky because I want my home server to provision my work station, which is not public.
I assume that you already generate an ssh keypair for ansible.

1. Configure remote host

Authorize access from remote to home :

```bash
# On remote host
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDwy8p7u84jgvDzlv6DTTCyaw8BT8mCE9qhdRoTfLbltrzziQPknM9S3e9k0DPn5+7Vjcg1hCuk7pBX8WDgSUF+ns2pDo1ebunds9MU5jkImwzOsT1GQbkkytRBpq6F9TDfaODluLLIhmS3jELwULXDTr92QgncWDHdb+IrhoWpVBEp2nQQF7RSVDZ4BHQGlvW1wgVAbEmJxbUvs9blNpTGm2flFzlqZfdOLYDSb3aXSmwMcLQDgk8qCbgcsJ1jX4qBwEv8Qv0tKECRhP+aNtmgH8m1noaDBbkFBVPRvP0N5C8SPNVn767yoMMzVtPt33poC4Uz1Uxdy8cP1OzsPsAx ansible@unsecure-key" | tee -a /home/$USER/.ssh/authorized_keys
```

You may need some conf in your .ssh/config :
```bash
Host home
    Hostname somepublicurl.net
    User xavier
    RemoteForward 9922 127.0.0.1:22
```

From remote host, open access to home :
```bash
ssh home
```

2. Access from provisioning VM to remote

On ansible server, you can now access to devm :
```bash
ssh -i $HOME/.ssh/ansible/id_key USER@127.0.0.1 -p 9922
```

