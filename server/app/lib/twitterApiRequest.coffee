twitterAPI = require 'node-twitter-api'

twitter = new twitterAPI({
    consumerKey: '8tvG5vOzV4qZmTxskVL3zQ',
    consumerSecret: 'CoPIIKC82ikOlnQufEGzE5Q8CUfFabpyXDEiztmGVo',
    callback: 'http://tcbyn.com'
});

module.exports = twitter