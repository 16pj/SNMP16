0. Copy the python script into the folder where SNMPprobe.pl was stored
1. Install influxdb and grafana
2. In influxdb create a database named robin
3. Open grafana and choose Data sources and choose influxdb as the source
4. select the dashboard button and choose import. Upload the .json file.
5. Set the default parameters and type database name as robin
6. Run the python file as -> python Ratewrapper.py [arguments]
$ut instance)
8. Eg: python Ratewrapper.py localhost 161 public 3 1.3.6.1.4.1.4171.40.2 1.3.6.1.4.1.4171.40.3






