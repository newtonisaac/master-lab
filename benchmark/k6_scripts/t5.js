import http from 'k6/http';
import { check } from "k6";

export let options = {
  scenarios: {
    t5_node: {
      executor: 'constant-vus',
      vus: 1,
      exec:  'node',
      duration: '20s',
      tags: { 
        type: 't5',
        target: __ENV.TARGET,
        simulation: __ENV.SIMULATION,
        users: '1',
        code: 'node'
      }
    },
    t5_python: {
      executor: 'constant-vus',
      vus: 1,
      exec:  'python',
      duration: '20s',
      tags: { 
        type: 't5',
        target: __ENV.TARGET,
        simulation: __ENV.SIMULATION,
        users: '1',
        code: 'python'
      }
    },
    t5_php: {
      executor: 'constant-vus',
      vus: 1,
      exec:  'php',
      duration: '20s',
      tags: { 
        type: 't5',
        target: __ENV.TARGET,
        simulation: __ENV.SIMULATION,
        users: '1',
        code: 'php'
      }
    },
    t5_java: {
      executor: 'constant-vus',
      vus: 1,
      exec:  'java',
      duration: '20s',
      tags: { 
        type: 't5',
        target: __ENV.TARGET,
        simulation: __ENV.SIMULATION,
        users: '1',
        code: 'java'
      }
    },
    t5_go: {
      executor: 'constant-vus',
      vus: 1,
      exec:  'go',
      duration: '20s',
      tags: { 
        type: 't5',
        target: __ENV.TARGET,
        simulation: __ENV.SIMULATION,
        users: '1',
        code: 'go'
      }
    },
    t5_csharp: {
      executor: 'constant-vus',
      vus: 1,
      exec:  'csharp',
      duration: '20s',
      tags: { 
        type: 't5',
        target: __ENV.TARGET,
        simulation: __ENV.SIMULATION,
        users: '1',
        code: 'csharp'
      }
    }
  }
}

export default function node() {
  const response = http.get(__ENV.LOAD_ENDPOINT_NODE);  
  check(response, { "success": (r) => r.status === 200 });
};

export default function python() {
  const response = http.get(__ENV.LOAD_ENDPOINT_PYTHON);  
  check(response, { "success": (r) => r.status === 200 });
};

export default function php() {
  const response = http.get(__ENV.LOAD_ENDPOINT_PHP);  
  check(response, { "success": (r) => r.status === 200 });
};

export default function java() {
  const response = http.get(__ENV.LOAD_ENDPOINT_JAVA);  
  check(response, { "success": (r) => r.status === 200 });
};

export default function go() {
  const response = http.get(__ENV.LOAD_ENDPOINT_GO);  
  check(response, { "success": (r) => r.status === 200 });
};

export default function csharp() {
  const response = http.get(__ENV.LOAD_ENDPOINT_CSHARP);  
  check(response, { "success": (r) => r.status === 200 });
};

