require 'fluentnode'

program      = require('commander');
DigitalOcean = require('do-wrapper')
sprintf      = require("sprintf-js").sprintf

String::line = ()->
  @ + require('os').EOL

class DigitalOcean_API
  constructor: ->
    @.api_key = process.env.api_key
    @.api     = new DigitalOcean @.api_key, 25  # 2nd value is 'per_page'

  create: (callback)=>
    configuration =
      "name": "new-droplet",
      "region": "lon1",
      "size": "512mb",
      "image": "ubuntu-14-04-x64",
      #"ssh_keys": ['0d:53:e1:59:9f:f1:41:26:a8:a7:ac:9f:d3:90:45:c8'],
      "backups": false,
      "ipv6": true,
      #"user_data": user_data,
      "user_data": null,
      "private_networking": null
    @.api.dropletsCreate configuration,  (err, res, body)->
      callback body.droplet
      #log "New Droplet created with id: #{body.droplet.id}"

#log body.json_Pretty()
  info: (options, callback)=>
    id = options.parent.args.first()
    log "Info about Droplet with id #{id}"
    @.api.dropletsGetById id,  (err, res, body)->
      #if res.statusCode isnt 204
      callback body.json_Pretty()

  list: (callback)=>
    data = sprintf('%10s | %20s | %10s | %10s | %10s | %10s', 'id', 'name', 'status', 'region', 'locked', 'ip').line()
    @.api.dropletsGetAll {}, (err, res, body)->
      for droplet in body.droplets
        data += sprintf('%10s | %20s | %10s | %10s | %10s | %10s'.line(),
                  droplet.id, droplet.name, droplet.status, droplet.region.slug, droplet.locked, droplet.networks.v4.first().ip_address)
      callback data
        


module.exports = DigitalOcean_API