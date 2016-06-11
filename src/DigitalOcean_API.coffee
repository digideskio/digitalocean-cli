require 'fluentnode'
program      = require('commander');
DigitalOcean = require('do-wrapper')

class DigitalOcean_API
  constructor: ->
    @.api_key = process.env.api_key


module.exports = DigitalOcean_API