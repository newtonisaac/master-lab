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

const getEndpoint = () => {
  switch (__ENV.MEMORY) {
    case '128' || 128:
      return "m128." + _ENV.LOAD_ENDPOINT 
    case '256' || 256:
      return "m256." + _ENV.LOAD_ENDPOINT 
    case '512' || 512:
      return "m512." + _ENV.LOAD_ENDPOINT 
    case '1024' || 1024:
      return "m1024." + _ENV.LOAD_ENDPOINT 
    case '2048' || 2048:
      return "m2048." + _ENV.LOAD_ENDPOINT           
  }
}


export default function () {
  const response = http.get(getEndpoint());  
  check(response, { "success": (r) => r.status === 200 });
};
