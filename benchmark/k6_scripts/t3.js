import http from 'k6/http';
import { check, sleep } from "k6";

export let options = {
  scenarios: {
    t3_warm: {
      executor: 'constant-vus',
      vus: 1,
      duration: '20s',
      gracefulStop: '0s',
      tags: { 
        type: 't3',
        target: __ENV.TARGET,
        simulation: __ENV.SIMULATION,
        users: 1,
        sleep: 0
      }
    },
    t3: {
      executor: 'constant-vus',
      vus: 1,
      exec: 't3',
      startTime: '20s',
      gracefulStop: '0s',
      tags: { 
        type: 't3',
        target: __ENV.TARGET,
        simulation: __ENV.SIMULATION,
        users: 1,
      }
    },
  }
}

export default function () {
  const response = http.get(__ENV.LOAD_ENDPOINT);  
  check(response, { "success": (r) => r.status === 200 });
};

const N = 10;

var timeWaiting = new Trend('t3_time_waiting');

export default function t3() {
  for (let i = 1; i <= N; ++i) {
    const response = http.get(__ENV.LOAD_ENDPOINT);  
    check(response, { "success": (r) => r.status === 200 });
    timeWaiting.add(30 * i)
    sleep(30 * i)
  }
};
