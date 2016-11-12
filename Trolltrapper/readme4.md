1) Install mysql and Create a mysql table using the following
mysql> create table traptroll (currstat VARCHAR(50), FQDNfail VARCHAR(50), mantimefail VARCHAR(50), prevstat VARCHAR(50), mantimeprevstat VARCHAR(50));
2) Install apache2 and copy the .php and .conf files into /var/www/html
3) Make sure privileges are provided
4) Copy sqltrap.pl to /usr/local/share/snmp/
5) Copy the snmptrapd.conf to /etc/snmp/
6) Restart snmptrapd with snmptrapd -c /etc/snmp/snmptrapd.conf
7) Send requests to port 50163
