'use strict';

const express = require('express');
const { performance } = require('perf_hooks');

// Constants
const PORT = 8080;
const HOST = '0.0.0.0';

// Logic
const fibonacci = (num) => {
  if (num <= 1) return 1;

  return fibonacci(num - 1) + fibonacci(num - 2);
}

// App
const app = express();

app.get('/', (req, res) => {
  res.send("Hello World Node!");
});

app.get('/fibonacci/:number', (req, res) => {
  
  const start = performance.now()
    const result = fibonacci(req.params.number);
  const end = performance.now()

  res.send({ result:result, time: end - start });
});

app.post('/payload', (req, res) => {
  res.send(req.body);
});

app.listen(PORT, HOST);
