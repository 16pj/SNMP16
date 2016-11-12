# SNMP16
A set of SNMP tools, including a model counter, rate calculator and trap handler with web interface

1. Counter is a Perl tool that models an SNMP counter and registers Enterprise OID .1.3.6.1.4.1.4171.40 to create dynamically allocated counters.
The counters.conf file can be used to assign the number and the rate of the counters. 

2. Prober is a Python tool that probes at the OIDS provided as arguments.
It prints out the rate of change of the counters at the OIDS.

3. Ratewrapper is a Python wrapper script to send the rates calculated by Prober into an Influxdb and hence, Grafana. The required dashboard json file is also provided.
It requires manual setting up of datasources in Grafana.

4. Trolltrapper is an SNMP traphandling system that is written in Perl and the web interface requires Apache and MySQL.
This system handles traps receives DANGER and FAIL traps sent from other devices to the local IP and sends traps to the IP address specified by the Web interface via table.php.
