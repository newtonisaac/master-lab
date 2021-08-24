import http from 'k6/http';
import { check } from "k6";

export let options = {
  scenarios: {
    t7_0: {
      executor: 'constant-vus',
      vus: 1,
      duration: '20s',
      tags: { 
        type: 't7',
        target: __ENV.TARGET,
        simulation: __ENV.SIMULATION,
        users: '1',
        fibonacci: 0
      },
      env: { NUMBER: 0 },
    },
    t7_5: {
      executor: 'constant-vus',
      vus: 1,
      duration: '20s',
      tags: { 
        type: 't7',
        target: __ENV.TARGET,
        simulation: __ENV.SIMULATION,
        users: '1',
        fibonacci: 5
      },
      env: { NUMBER: 5 },
    },
    t7_10: {
      executor: 'constant-vus',
      vus: 1,
      duration: '20s',
      tags: { 
        type: 't7',
        target: __ENV.TARGET,
        simulation: __ENV.SIMULATION,
        users: '1',
        fibonacci: 10
      },
      env: { NUMBER: 10 },
    },
    t7_15: {
      executor: 'constant-vus',
      vus: 1,
      duration: '20s',
      tags: { 
        type: 't7',
        target: __ENV.TARGET,
        simulation: __ENV.SIMULATION,
        users: '1',
        fibonacci: 15
      },
      env: { NUMBER: 15 },
    },
    t7_20: {
      executor: 'constant-vus',
      vus: 1,
      duration: '20s',
      tags: { 
        type: 't7',
        target: __ENV.TARGET,
        simulation: __ENV.SIMULATION,
        users: '1',
        fibonacci: 20
      },
      env: { NUMBER: 20 },
    },
    t7_25: {
      executor: 'constant-vus',
      vus: 1,
      duration: '20s',
      tags: { 
        type: 't7',
        target: __ENV.TARGET,
        simulation: __ENV.SIMULATION,
        users: '1',
        fibonacci: 25
      },
      env: { NUMBER: 25 },
    },
    t7_30: {
      executor: 'constant-vus',
      vus: 1,
      duration: '20s',
      tags: { 
        type: 't7',
        target: __ENV.TARGET,
        simulation: __ENV.SIMULATION,
        users: '1',
        fibonacci: 30
      },
      env: { NUMBER: 30 },
    },
    t7_35: {
      executor: 'constant-vus',
      vus: 1,
      duration: '20s',
      tags: { 
        type: 't7',
        target: __ENV.TARGET,
        simulation: __ENV.SIMULATION,
        users: '1',
        fibonacci: 35
      },
      env: { NUMBER: 35 },
    },
    t7_40: {
      executor: 'constant-vus',
      vus: 1,
      duration: '20s',
      tags: { 
        type: 't7',
        target: __ENV.TARGET,
        simulation: __ENV.SIMULATION,
        users: '1',
        fibonacci: 40
      },
      env: { NUMBER: 40 },
    },
  }
}



export default function () {
  const response = http.get(__ENV.LOAD_ENDPOINT + __ENV.NUMBER);  
  check(response, { "success": (r) => r.status === 200 });
};
