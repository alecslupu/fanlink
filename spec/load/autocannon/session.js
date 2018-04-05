'use strict'

const http = require('http')
const autocannon = require('autocannon')

function handle (req, res) {
  res.end('hello world')
}

function startBench () {
  const url = 'http://localhost:3000'

  autocannon({
    url: url,
    connections: 1,
    duration: 0.1,
    headers: {
      // by default we add an auth token to all requests
      Accept: 'application/vnd.api.v1+json',
      'Content-Type': 'application/json'
    },
    requests: [
      {
        method: 'POST', // this should be a post for logging in
        path: '/session',
        body: JSON.stringify({
          product:'inna',
          email_or_username: 'mark',
          password: 'mc2219'
        })
        // overwrite our default headers,
        // so we don't add an auth token
        // for this request
       // headers: {}
      },
      {
        method: 'GET',
        path: '/session'
        // this will automatically add the pregenerated auth token
      }
      // {
      //   method: 'PUT', // this should be a put for modifying secret details
      //   path: '/mySecretDetails',
      //   headers: { // let submit some json?
      //     'Content-type': 'application/json; charset=utf-8'
      //   },
      //   // we need to stringify the json first
      //   body: JSON.stringify({
      //     name: 'my new name'
      //   })
      // }
    ]
  }, finishedBench)

  function finishedBench (err, res) {
    console.log('finished bench', err, res)
  }
}

startBench();
