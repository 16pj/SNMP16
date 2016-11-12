0. Make sure NetSNMP-agent module of Perl is installed.
1. Create a folder in home called proj -> sudo  mkdir /home/proj
2. Copy all the attached files into /home/proj and cd /home/proj
3. Copy snmpd.conf into /etc/snmp/ -> sudo cp snmpd.conf /etc/snmp/snmpd.conf
4. restart snmpd server -> sudo service snmpd restart
5. do an snmpget to test if the agent works -> snmpget -v 2c -c public localhost 1.3.6.1.4.1.4171.40.1.0
