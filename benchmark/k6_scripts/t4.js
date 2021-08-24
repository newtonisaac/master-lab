import http from 'k6/http';
import { check } from "k6";

const generatePayload = (lenght) => {
  let payload = ''
  for (let i = 0; i < 50; i++) {
    payload = payload + "a"
  }
  return payload
}

const payload32 = generatePayload(32)
const payload64 = generatePayload(64)
const payload96 = generatePayload(96)
const payload128 = generatePayload(128)
const payload160 = generatePayload(160)
const payload192 = generatePayload(192)
const payload224 = generatePayload(224)
const payload256 = generatePayload(256)

export let options = {
  scenarios: {
    t4_0: {
      executor: 'constant-vus',
      vus: 1,
      duration: '20s',
      tags: { 
        type: 't1',
        target: __ENV.TARGET,
        simulation: __ENV.SIMULATION,
        users: '1',
        payload: 0
      },
      env: { PAYLOAD: '' },
    },
    t4_32: {
      executor: 'constant-vus',
      vus: 1,
      duration: '20s',
      tags: { 
        type: 't1',
        target: __ENV.TARGET,
        simulation: __ENV.SIMULATION,
        users: '1',
        payload: 32
      },
      env: { PAYLOAD: payload32 },
    },
    t4_64: {
      executor: 'constant-vus',
      vus: 1,
      duration: '20s',
      tags: { 
        type: 't1',
        target: __ENV.TARGET,
        simulation: __ENV.SIMULATION,
        users: '1',
        payload: 64
      },
      env: { PAYLOAD: payload64 },
    },
    t4_96: {
      executor: 'constant-vus',
      vus: 1,
      duration: '20s',
      tags: { 
        type: 't1',
        target: __ENV.TARGET,
        simulation: __ENV.SIMULATION,
        users: '1',
        payload: 96
      },
      env: { PAYLOAD: payload96 },
    },
    t4_128: {
      executor: 'constant-vus',
      vus: 1,
      duration: '20s',
      tags: { 
        type: 't1',
        target: __ENV.TARGET,
        simulation: __ENV.SIMULATION,
        users: '1',
        payload: 128
      },
      env: { PAYLOAD: payload128 },
    },
    t4_160: {
      executor: 'constant-vus',
      vus: 1,
      duration: '20s',
      tags: { 
        type: 't1',
        target: __ENV.TARGET,
        simulation: __ENV.SIMULATION,
        users: '1',
        payload: 160
      },
      env: { PAYLOAD: payload160 },
    },
    t4_192: {
      executor: 'constant-vus',
      vus: 1,
      duration: '20s',
      tags: { 
        type: 't1',
        target: __ENV.TARGET,
        simulation: __ENV.SIMULATION,
        users: '1',
        payload: 192
      },
      env: { PAYLOAD: payload192 },
    },
    t4_224: {
      executor: 'constant-vus',
      vus: 1,
      duration: '20s',
      tags: { 
        type: 't1',
        target: __ENV.TARGET,
        simulation: __ENV.SIMULATION,
        users: '1',
        payload: 224
      },
      env: { PAYLOAD: payload224 },
    },
    t4_256: {
      executor: 'constant-vus',
      vus: 1,
      duration: '20s',
      tags: { 
        type: 't1',
        target: __ENV.TARGET,
        simulation: __ENV.SIMULATION,
        users: '1',
        payload: payload256
      },
      env: { PAYLOAD: payload256 },
    },
  }
}



export default function () {
  const response = http.post(__ENV.LOAD_ENDPOINT, payload__ENV.PAYLOAD);  
  check(response, { "success": (r) => r.status === 200 });
};
