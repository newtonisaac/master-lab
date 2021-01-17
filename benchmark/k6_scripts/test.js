import http from 'k6/http';
import { check, sleep } from "k6";
import { Trend } from 'k6/metrics';

export let options = {
  scenarios: {
    spike: {
      executor: 'ramping-vus',
      startVUs: 0,
      stages: [
        { duration: '2s', target: 1 },
      ],
      gracefulRampDown: '0s',
      tags: { 
        type: 'test', 
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
  sleep(.300);
};
