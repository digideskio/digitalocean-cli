#!/usr/bin/env coffee
program = require('commander');
flentnode    = require 'fluentnode'
DigitalOcean = require('do-wrapper')


api_key = process.env.api_key

log 'DigitalOcean CLI';
log '----------------'

program
  .version('0.0.1')
  #.option('-d, --droplets', 'List droplets')

api = new DigitalOcean(api_key, 25);


user_data= "./tm_install.sh".file_Contents()

program.command 'list'
       .description 'Gets list of droplets'
       .action (env, options)->
         log "id | name | status | region | locked | ip"
         api.dropletsGetAll {}, (err, res, body)->
           for droplet in body.droplets
             log "#{droplet.id} | #{droplet.name} |  #{droplet.status} | #{droplet.region.slug} | #{droplet.locked} | #{droplet.networks.v4.first().ip_address}"
           #log '--------'

program.command 'info'
       .description 'Gets droplet information'
       .action (env, options)->
         id = options.parent.args.first()
         log "Deleting Droplet with id #{id}"
         api.dropletsGetById id,  (err, res, body)->
           #if res.statusCode isnt 204
           log body.json_Pretty()


program.command 'create'
       .description 'Gets list of droplets'
       .action (env, options)->
         log 'Creating new droplet'
         configuration =
           "name": "tm-test",
           "region": "lon1",
           "size": "512mb",
           "image": "ubuntu-14-04-x64",
           "ssh_keys": ['0d:53:e1:59:9f:f1:41:26:a8:a7:ac:9f:d3:90:45:c8'],
           "backups": false,
           "ipv6": true,
           "user_data": user_data,
           "private_networking": null
         api.dropletsCreate configuration,  (err, res, body)->
           log "New Droplet created with id: #{body.droplet.id}"
           #log body.json_Pretty()

program.command 'delete'
       .description 'Delete Droplet <id>'
       .action (env, options)->
         id = options.parent.args.first()
         log "Deleting Droplet with id #{id}"
         api.dropletsDelete id,  (err, res, body)->
           if res.statusCode isnt 204
             log body

program.command 'delete-all'
       .description 'Deleting all droplets'
       .action (env, options)->
         api.dropletsGetAll {}, (err, res, body)->
           for droplet in body.droplets
             log "Deleting Droplet with id #{droplet.id}"
             api.dropletsDelete droplet.id,  (err, res, body)->
               if res.statusCode isnt 204
                 log body

           #else
          #   log "Droplet is being deleted"

program.parse(process.argv);
