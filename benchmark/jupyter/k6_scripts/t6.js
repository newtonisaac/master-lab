import http from 'k6/http';
import { check } from "k6";

export let options = {
  scenarios: {
    t6: {
      executor: 'ramping-vus',
      gracefulStop: '0s',
      gracefulRampDown: '0s',
      startVUs: 0,
      stages: [
        { duration: '60s', target: 60 },
      ],
      startTime: '0s',
      tags: { 
        type: 't6',
        target: __ENV.TARGET,
        simulation: __ENV.SIMULATION,
        memory: __ENV.MEMORY
      }
    }
  }
}


export default function () {
  const response = http.get(_ENV.LOAD_ENDPOINT);  
  check(response, { "success": (r) => r.status === 200 });
};
