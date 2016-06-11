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

  list: (callback)=>
    data = sprintf('%10s | %20s | %10s | %10s | %10s | %10s', 'id', 'name', 'status', 'region', 'locked', 'ip').line()
    @.api.dropletsGetAll {}, (err, res, body)->
      for droplet in body.droplets
        data += sprintf('%10s | %20s | %10s | %10s | %10s | %10s'.line(),
                  droplet.id, droplet.name, droplet.status, droplet.region.slug, droplet.locked, droplet.networks.v4.first().ip_address)
        callback data
        
  info: (options, callback)=>
    id = options.parent.args.first()
    log "Info about Droplet with id #{id}"
    @.api.dropletsGetById id,  (err, res, body)->
      #if res.statusCode isnt 204
      callback body.json_Pretty()


module.exports = DigitalOcean_API