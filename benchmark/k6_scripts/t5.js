import http from 'k6/http';
import { check } from "k6";

export let options = {
  scenarios: {
    t5: {
      executor: 'ramping-vus',
      gracefulStop: '0s',
      gracefulRampDown: '0s',
      startVUs: 0,
      stages: [
        { duration: '60s', target: 60 },
      ],
      startTime: '0s',
      tags: { 
        type: 't5',
        target: __ENV.TARGET,
        simulation: __ENV.SIMULATION,
        language: __ENV.LANGUAGE
      }
    }
  }
}

export default function () {
  const response = http.get(__ENV.LOAD_ENDPOINT);  
  check(response, { "success": (r) => r.status === 200 });
};
