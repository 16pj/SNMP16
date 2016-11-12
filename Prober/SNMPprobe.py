from easysnmp import Session

import sys, time

arrs = sys.argv

if(len(arrs)<4):
	print "Insufficient Arguments"
else:

	timearray = []
	valarray = []
	timearray.append(0)
	timearray.append(0)
	timearray.append(0)
	y=0
	#timearray.append(0)
	#valarray.append(0)

	oids = ['1.3.6.1.2.1.1.3.0']

	for i in range(len(arrs)):
		if (i>4):
			oidstr="%s" %arrs[i]
			oids.append(oidstr)
	tick = float(arrs[4])
	click = int(tick)

	#print oids
	session = Session(hostname=arrs[1], community=arrs[3], version=2, remote_port= arrs[2],timeout=1,retries=1000)
	timdiff = 0
	timdiff = 0
	restartflag = 0
	while(1):
		ti = time.time()
		if(restartflag==1):
			timearray = []
			valarray = []
			timearray.append(0)
			timearray.append(0)
			timearray.append(0)
			restartflag=0
	
			
		
		vallist = session.get(oids)
		
	
		if(int(vallist[0].value)>timearray[0]):
		    
	             	if(len(valarray)<len(vallist)):	
		   		for i in range(len(vallist)):
					valarray.append([])
					valarray[i].append(0)
					valarray[i].append(0)
					valarray[i].append(0)
		
	
			for i in range(len(vallist)):
	
				if(i==0):
					#print "Time ",int(vallist[0].value), " ", timearray[0]
					if(timearray[2]!=0):
						print int(time.time()),
	
					if(int(vallist[0].value)<timearray[2]):
						#print "Restart"
						break;
					else: 
						timdiff = (float(vallist[0].value)-timearray[2])
						#print "Time diff", timdiff
				else:
					#try:
	
						if(valarray[i][2]<=float(vallist[i].value)):
							#print "Value ",x,
							valdiff = float(vallist[i].value) - valarray[i][2]
							if(timearray[2]!=0):
								pass
								print " ",float(valdiff/(timdiff/100)),
								#print " Diff ",float(valdiff/(timdiff/100))," zero ",valarray[i][0]," sub ",valdiff," timdiff ",(timdiff/100)," two ",valarray[i][2]," new ",float(vallist[i].value)
							valarray[i][2]=float(vallist[i].value)
	
	
						else:
						    if((timearray[1]-timearray[0])!=0):
							y1=(float(vallist[0].value)-timearray[1])*((valarray[i][1]-valarray[i][0])/(timearray[1]-timearray[0]))+valarray[i][1]
							#y=-int(y/timdiff)
							#print " Neg ", y,
							#print "\nt2 is ",timearray[2]," new time is  ",float(vallist[0].value), " val2 is ", valarray[i][2], " val1 is ", valarray[i][1]		
							#valarray[i][2] = y1
							valdiff = y1-valarray[i][1]
							#print " neg ",float(valdiff/((float(vallist[0].value)-timearray[1])))," ",valarray[i][0]," ",valarray[i][1]," ",valarray[i][2]
							#valarray[i][2] = y
							if(timearray[2]!=0):
								print " ",float(valdiff/((float(vallist[0].value)-timearray[1]))),
							valarray[i][2]=float(vallist[i].value)
							
						valarray[i][0]=valarray[i][1]
						valarray[i][1]=valarray[i][2]
	
	
	
			timearray[0]=timearray[1]	
			timearray[1]=timearray[2]	
			timearray[2]=float(vallist[0].value)
	
	
					#except: 
						#print "Not an integer ",
			to=time.time()
			if(to-ti):
				tick=click-(to-ti)
			else:
				tick=click
			#print "program  time is ", (to-ti)			
			print "\n",
			time.sleep(tick)
	
		else:
			timearray = []
			valarray = []
			timearray.append(0)
			timearray.append(0)
			timearray.append(0)
			restartflag=1
