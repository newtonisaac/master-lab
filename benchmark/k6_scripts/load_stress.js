import http from 'k6/http';
import { check } from "k6";
import { Trend } from 'k6/metrics';


export let options = {
  scenarios: {
    stress: {
      executor: 'ramping-vus',
      startVUs: 10,
      stages: [
        { duration: '30s', target: 100 },
        { duration: '30s', target: 200 },
        { duration: '30s', target: 300 },
        { duration: '30s', target: 300 },
        { duration: '30s', target: 200 },
        { duration: '30s', target: 100 },
      ],
      gracefulRampDown: '0s',
      tags: { 
              type: 'stress', 
              simulation: __ENV.SIMULATION 
            }
    }
  }
}

let ptMetric = new Trend('processing_time');

export default function () {
  const response = http.get(__ENV.LOAD_ENDPOINT);
  
  if(response.status === 200){
    let jsonResponse = JSON.parse(response.body);
    ptMetric.add(jsonResponse.time)  
  }
  
  check(response, { "status is 200": (r) => r.status === 200 });
};
