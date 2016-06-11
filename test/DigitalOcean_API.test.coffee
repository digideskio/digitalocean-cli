DigitalOcean_API = require '../src/DigitalOcean_API'

describe 'DigitalOcean_API', ->
  
  it 'constructor',->
    using new DigitalOcean_API, ->
      @.api_key.assert_Is_String()
      @.api.per_page.assert_Is 25

  ### method's tests ###

  it 'list',(done)->
    using new DigitalOcean_API, ->
      @.list (data)->
        data.assert_Contains '      id |                 name |     status |     region |     locked |         ip'
        data.split("".line()).assert_Size_Is_Bigger_Than 1
        done() 

  it 'info', (done)->
    using new DigitalOcean_API, ->
      @.api.dropletsGetAll {}, (err, res, body)=>
        id = body.droplets.first().id.assert_Is_Number()
        options = parent : args : [ id ]
        @.info options, (data)->
          data.assert_Contains id
          done()

  ### misc tests ###
  it 'should have @.api_key set from environment variable', ->
    using new DigitalOcean_API, ->
      @.api_key.assert_Is_String()      # in OSX this is set using: export api_key={key}
