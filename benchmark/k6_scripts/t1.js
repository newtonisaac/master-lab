import http from 'k6/http';
import { check } from "k6";

export let options = {
  scenarios: {
    t1: {
      executor: 'constant-vus',
      vus: 1,
      duration: '20s',
      tags: { 
        type: 't1',
        target: __ENV.TARGET,
        simulation: __ENV.SIMULATION,
        users: '1'
      }
    },
  }
}

export default function () {
  const response = http.get(__ENV.LOAD_ENDPOINT);  
  check(response, { "success": (r) => r.status === 200 });
};
