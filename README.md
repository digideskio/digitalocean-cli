# digitalocean-cli
NodeJS CLI for [DigitalOcean]([https://www.digitalocean.com)

Written in CoffeeScript, based on [do-wrapper](https://www.npmjs.com/package/do-wrapper) npm package

# install

```
git clone git@github.com:o2platform/digitalocean-cli.git
cd digitalocean-cli
npm install
```

# configure

You will need to set the DigitalOcean API Key, for example in OSX you can use:

```
export api_key={key}
```

the commands are invoked using

```
./do-cli {command}
```

# commands

**-h** - shows the commands availabe
```
./do-cli -h
```

**list** - gets list of droplets

```
./do-cli list
```

**info {id}** - gets droplet information

```
./do-cli info {id}
```

**create** - creates a new droplet, using these values

```json
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

**delete {id}** - delete Droplet <id>

```
./do-cli delete {id}
```

**delete-all**  - deleting all droplets

```
./do-cli delete-all
```

**repl** - starts a javascript repl with the ```that``` variable set to the
```do-wrapper``` api. For example, here is how the ```dropletsGetAll``` is invoked

```
[fluentnode] repl> that.dropletsGetAll({}, function (err, res, body) { console.log(body)})
```

# issues/bugs

If you have a problem or idea for new feature please [open an issue for it](https://github.com/o2platform/digitalocean-cli/issues)
