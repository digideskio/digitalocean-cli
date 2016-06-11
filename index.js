require('coffee-script/register');
DigitalOcean_API = require('./src/DigitalOcean_API');

do_Api = new DigitalOcean_API()

do_Api.list(function (data) {
    console.log(data)

})