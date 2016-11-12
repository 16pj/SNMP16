#display out put line by line
import subprocess
import re
import os
import sys

arrs = sys.argv

main = ['perl','SNMPprobe.pl']
oids = []
arrs = sys.argv

for i in range(len(arrs)):
	if (i==0):
		pass
	else:
		str="%s" %arrs[i]
		main.append(str)
	if (i>4):
		oidstr="%s" %arrs[i]
		oids.append(oidstr)
#print oids

proc = subprocess.Popen(main,stdout=subprocess.PIPE)
#works in python 3.0+
#for line in proc.stdout:
for line in iter(proc.stdout.readline,''):
	line = line.rstrip()
	if(line == ''):
		pass
	else:
		lines = line.split(' ')      
		#print lines
		for i in range(len(lines)):
			if(i==0):
				time = lines[i]
				pass
			else:
				text = lines[i]
		
	
    				cmd = "curl -POST 'http://localhost:8086/write?db=robin' --data-binary '%s value=%s'" % (oids[i-1],text)
				os.system(cmd)
