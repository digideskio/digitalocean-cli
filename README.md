# digitalocean-cli
NodeJS CLI for [DigitalOcean]([https://www.digitalocean.com)

Written in CoffeeScript, based on [do-wrapper](https://www.npmjs.com/package/do-wrapper) npm package

## Install

```
npm install -g digitalocean-cli
```

This will add a ```do-cli``` mapping (symlinked into ./do-cli.cofffe),
which can be used like this ```do-cli.coffee {command}```

See list of commands bellow, or just execute

```
do-cli -h
```


## Install from source

```
git clone git@github.com:o2platform/digitalocean-cli.git
cd digitalocean-cli
npm install
```

After install you can use ```./do-cli.coffee {command}```

## Configure

You will need to set the DigitalOcean API Key, for example in OSX you can use:

```
export api_key={key}
```


## Commands

#### -h

Shows the commands availabe: ```do-cli -h```

### list

Gets list of droplets. Here is the info provided after executing ```./do-cli list```

```
id | name | status | region | locked | ip
5467866 | test-docker |  active | lon1 | false | 46.101.48.220
```

If this box was setup with an ssh key that currently exists on the local box,
you can connect to it using:

```ssh root@{ip}``` which in the example above is ```ssh root@46.101.48.220```

Note: if you are creating and deleting images regularly, digitalocean tends to reuse the IPs,
which means that you will see an ```WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!``` error
(with ssh failing to connect)

One way to deal with this is to use the command ```ssh-keygen -R {ip}``` (in this case ```ssh-keygen -R 46.101.48.220```).
After that, the ```ssh root@{ip}`` will work

#### info {id}

Gets droplet information: ```./do-cli info {id}```

#### create

Creates a new droplet, using these values

```coffee
configuration =
  "name": "new-droplet",
  "region": "lon1",
  "size": "512mb",
  "image": "ubuntu-14-04-x64",
  "ssh_keys": ['0d:53:e1:59:9f:f1:41:26:a8:a7:ac:9f:d3:90:45:c8'],
  "backups": false,
  "ipv6": true,
  "user_data": user_data,
  "private_networking": null
```

```
./do-cli create
```

#### delete {id}

Delete Droplet with <id>: ```./do-cli delete {id}```


#### Delete-all

Deletes all droplets: ```./do-cli delete-all```


#### repl

Starts a javascript repl with the ```that``` variable set to the
```do-wrapper``` api. For example, here is how the ```dropletsGetAll``` is invoked

```
[fluentnode] repl> that.dropletsGetAll({}, function (err, res, body) { console.log(body)})
```

## Issues/bugs

If you have a problem or idea for new feature please [open an issue for it](https://github.com/o2platform/digitalocean-cli/issues)
