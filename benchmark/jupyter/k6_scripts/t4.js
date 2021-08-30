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
const payload128 = generatePayload(128)
const payload256 = generatePayload(256)
const payload512 = generatePayload(512)

const getPayload = (payload) => {
  switch (payload) {
    case '32' || 32:
      return payload32
    case '64' || 32:
        return payload64
    case '128' || 128:
      return payload128
    case '256' || 256:
      return payload256
    case '512' || 512:
        return payload512
  }
}

export let options = {
  scenarios: {
    t4: {
      executor: 'ramping-vus',
      gracefulStop: '0s',
      gracefulRampDown: '0s',
      startVUs: 0,
      stages: [
        { duration: '60s', target: 60 },
      ],
      startTime: '0s',
      tags: {
        type: 't4',
        target: __ENV.TARGET,
        simulation: __ENV.SIMULATION,
        payload: __ENV.PAYLOAD
      }
    }
  }
}

export default function () {
  const response = http.post(__ENV.LOAD_ENDPOINT, getPayload(__ENV.PAYLOAD));
  check(response, { "success": (r) => r.status === 200 });
};
