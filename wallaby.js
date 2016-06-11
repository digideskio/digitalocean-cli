module.exports = function ( ) {
    return {
        files: [
            { pattern: '.env'},
            { pattern: 'src/**/*.coffee'}
        ],

        tests: [
            'test/**/*.coffee'
        ],

        testFramework: 'mocha',

        env: {
            type: 'node'
        },
        setup: function (wallaby) {
            require('dotenv').config()
        }
    };
};