import http from 'k6/http';
import { check } from "k6";

export let options = {
  scenarios: {
    t2_5: {
      executor: 'constant-vus',
      vus: 5,
      duration: '20s',
      tags: { 
        type: 't2',
        target: __ENV.TARGET,
        simulation: __ENV.SIMULATION,
        users: 5
      },
    },
    t2_10: {
      executor: 'constant-vus',
      vus: 10,
      duration: '20s',
      tags: { 
        type: 't2',
        target: __ENV.TARGET,
        simulation: __ENV.SIMULATION,
        users: 10
      },
    },
    t2_15: {
      executor: 'constant-vus',
      vus: 15,
      duration: '20s',
      tags: { 
        type: 't2',
        target: __ENV.TARGET,
        simulation: __ENV.SIMULATION,
        users: 15
      },
    },
    t2_20: {
      executor: 'constant-vus',
      vus: 20,
      duration: '20s',
      tags: { 
        type: 't2',
        target: __ENV.TARGET,
        simulation: __ENV.SIMULATION,
        users: 20
      },
    },
    t2_25: {
      executor: 'constant-vus',
      vus: 25,
      duration: '20s',
      tags: { 
        type: 't2',
        target: __ENV.TARGET,
        simulation: __ENV.SIMULATION,
        users: 25
      },
    },
    t2_30: {
      executor: 'constant-vus',
      vus: 30,
      duration: '20s',
      tags: { 
        type: 't2',
        target: __ENV.TARGET,
        simulation: __ENV.SIMULATION,
        users: 30
      },
    },
  }
}

export default function () {
  const response = http.get(__ENV.LOAD_ENDPOINT);  
  check(response, { "success": (r) => r.status === 200 });
};
