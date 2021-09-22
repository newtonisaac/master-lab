import http from 'k6/http';
import { check } from "k6";

export let options = {
  scenarios: {
    t3: {
      executor: 'ramping-vus',
      gracefulStop: '0s',
      gracefulRampDown: '0s',
      startVUs: 0,
      stages: [
        { duration: '1m', target: 60 },
        { duration: '1m', target: 120 },
        { duration: '1m', target: 240 },
        { duration: '1m', target: 120 },
        { duration: '1m', target: 60 }
      ],
      tags: { 
        type: 't3',
        target: __ENV.TARGET,
        simulation: __ENV.SIMULATION
      },
    }
  }
}

export default function () {
   const response = http.get(__ENV.LOAD_ENDPOINT);  
  check(response, { "success": (r) => r.status === 200 });
};
