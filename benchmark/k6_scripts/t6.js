import http from 'k6/http';
import { check } from "k6";

export let options = {
  scenarios: {
    t6_128: {
      executor: 'constant-vus',
      vus: 1,
      exec: 'm128',
      duration: '20s',
      tags: { 
        type: 't6',
        target: __ENV.TARGET,
        simulation: __ENV.SIMULATION,
        users: '1',
        memory: 128
      }
    },
    t6_256: {
      executor: 'constant-vus',
      vus: 1,
      exec: 'm256',
      duration: '20s',
      tags: { 
        type: 't6',
        target: __ENV.TARGET,
        simulation: __ENV.SIMULATION,
        users: '1',
        memory: 256
      }
    },
    t6_512: {
      executor: 'constant-vus',
      vus: 1,
      exec: 'm512',
      duration: '20s',
      tags: { 
        type: 't6',
        target: __ENV.TARGET,
        simulation: __ENV.SIMULATION,
        users: '1',
        memory: 512
      }
    },
    t6_1024: {
      executor: 'constant-vus',
      vus: 1,
      exec: 'm1024',
      duration: '20s',
      tags: { 
        type: 't6',
        target: __ENV.TARGET,
        simulation: __ENV.SIMULATION,
        users: '1',
        memory: 1024
      }
    },
    t6_2048: {
      executor: 'constant-vus',
      vus: 1,
      exec: 'm2048',
      duration: '20s',
      tags: { 
        type: 't6',
        target: __ENV.TARGET,
        simulation: __ENV.SIMULATION,
        users: '1',
        memory: 2048
      }
    }
  }
}



export default function m128() {
  const response = http.get(__ENV.LOAD_ENDPOINT_128);  
  check(response, { "success": (r) => r.status === 200 });
};

export default function m256() {
  const response = http.get(__ENV.LOAD_ENDPOINT_256);  
  check(response, { "success": (r) => r.status === 200 });
};

export default function m512() {
  const response = http.get(__ENV.LOAD_ENDPOINT_512);  
  check(response, { "success": (r) => r.status === 200 });
};

export default function m1024() {
  const response = http.get(__ENV.LOAD_ENDPOINT_1024);  
  check(response, { "success": (r) => r.status === 200 });
};


export default function m2048() {
  const response = http.get(__ENV.LOAD_ENDPOINT_2048);  
  check(response, { "success": (r) => r.status === 200 });
};