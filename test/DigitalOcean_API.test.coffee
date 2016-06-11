DigitalOcean_API = require '../src/DigitalOcean_API'

describe 'DigitalOcean_API', ->
  
  it 'constructor',->
    using new DigitalOcean_API, ->
      @.api_key.assert_Is_String()

  it 'should have @.api_key set from environment variable', ->
    using new DigitalOcean_API, ->
      @.api_key.assert_Is_String()      # in OSX this is set using: export api_key={key}
