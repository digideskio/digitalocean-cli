#!/usr/bin/env coffee
program = require('commander');
flentnode    = require 'fluentnode'
DigitalOcean = require('do-wrapper')

DigitalOcean_API = require './src/DigitalOcean_API'
do_API = new DigitalOcean_API();

api_key = process.env.api_key

log 'DigitalOcean CLI';
log '----------------'

if not api_key
  log 'Error: the environment variable api_key is not set.'
  process.exit (1)

program
  .version('0.0.1')

api = new DigitalOcean(api_key, 25);


#user_data= "./tm_install.sh".file_Contents()

program.command 'list'
       .description 'Gets list of droplets'
       .action (env, options)->
          do_API.list (data)->
            log data

         #log "id | name | status | region | locked | ip"
         #api.dropletsGetAll {}, (err, res, body)->
         #  for droplet in body.droplets
         #    log "#{droplet.id} | #{droplet.name} |  #{droplet.status} | #{droplet.region.slug} | #{droplet.locked} | #{droplet.networks.v4.first().ip_address}"
         #  #log '--------'

program.command 'info'
       .description 'Gets droplet information'
       .action (env, options)->
          do_API.info options, (data)->
            log data
         #id = options.parent.args.first()
         #log "Info about Droplet with id #{id}"
         #api.dropletsGetById id,  (err, res, body)->
         #  #if res.statusCode isnt 204
         #  log body.json_Pretty()


program.command 'create'
       .description 'Creates a new droplet'
       .action (env, options)->
          log 'Creating new droplet'
          do_API.create (droplet)->
            log "New Droplet created with id: #{droplet.id}"
#         configuration =
#           "name": "new-droplet",
#           "region": "lon1",
#           "size": "512mb",
#           "image": "ubuntu-14-04-x64",
#           "ssh_keys": ['0d:53:e1:59:9f:f1:41:26:a8:a7:ac:9f:d3:90:45:c8'],
#           "backups": false,
#           "ipv6": true,
#           #"user_data": user_data,
#           "user_data": null,
#           "private_networking": null
#         api.dropletsCreate configuration,  (err, res, body)->
#           log "New Droplet created with id: #{body.droplet.id}"
#           #log body.json_Pretty()

program.command 'delete'
       .description 'Delete Droplet {id}'
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

program.command 'repl'
       .description 'provides a repl to the base api'
       .action (env, options)->
         api.repl_Me()


program.parse(process.argv);
