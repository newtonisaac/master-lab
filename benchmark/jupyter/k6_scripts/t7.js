import http from 'k6/http';
import { check } from "k6";

export let options = {
  scenarios: {
    t7: {
      executor: 'ramping-vus',
      gracefulStop: '0s',
      gracefulRampDown: '0s',
      startVUs: 0,
      stages: [
        { duration: '60s', target: 60 },
      ],
      startTime: '0s',
      tags: { 
        type: 't7',
        target: __ENV.TARGET,
        simulation: __ENV.SIMULATION,
        fnumber: __ENV.FNUMBER
      }
    }
  }
}

export default function () {
  const response = http.get(__ENV.LOAD_ENDPOINT + __ENV.FNUMBER );  
  check(response, { "success": (r) => r.status === 200 });
};
