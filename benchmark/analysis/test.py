# python3 -m pip install influxdb
from influxdb import InfluxDBClient


idb = InfluxDBClient(host='localhost', port=8086)

#print(idb.get_list_database())
idb.switch_database('k6')
print(idb.get_list_measurements())

print(idb.query('SELECT * FROM "processing_time"'))