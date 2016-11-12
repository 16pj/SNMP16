 #!/usr/bin/perl

  use strict;
  use warnings;
  use DBI;

sub rtrim { my $s = shift; $s =~ s/\s+$//; return $s };

my $dbh = DBI->connect("DBI:mysql:database=robin;host=localhost",
                         "root", "password",
                         {'RaiseError' => 1});

my $stat1;
my $stat2;
my $res;
my $query;
my $prev=0;
my $prevtime=0;
my $stri;
my $row;
my $trap;
my $input_file = "/var/www/html/troll.conf";

my $FQDNrep = "DEFAULT";
my $currstat = "DEFAULT";
my $FQDNfail = "DEFAULT";
my $mantimefail = "DEFAULT";
my $prevstat = "DEFAULT";
my $mantimeprevstat = "DEFAULT";




sub trap_receiver {
open FILE, ">>", "trolltraplog.txt" or die $!;
   print "********** YOU'VE GOT MAIL:\n";
   print FILE "\nNEW MAIL:\n";
   foreach my $x (@{$_[1]}) 
{ 

	#printf FILE "  %-30s type=%-2d value=%s\n", $x->[0], $x->[2], $x->[1];
 
	$stat1=sprintf ("%-30s", $x->[0]);

	if($stat1 eq "SNMPv2-SMI::enterprises.41717.10.1")
		{
		$stat2=sprintf ("%-30s", $x->[1]);
		$stat2 = substr $stat2, 8;
		print "\nFQDN of device with FAIL is $stat2\n";
		print FILE "\nFQDN of device with FAIL is $stat2\n";

		$FQDNfail = $stat2;

		}

	elsif($stat1 eq "SNMPv2-SMI::enterprises.41717.10.2")
		{
		$stat2=sprintf ("%-30s", $x->[1]);
		$stat2 = substr $stat2, 9;
		print "\nStatus integer is $stat2\n";
		print FILE "\nStatus integer is $stat2\n";
		
		$currstat = $stat2;
		

		if($currstat==3)	 {
		open (INPUT_FILE, "<$input_file")  || die "Can't open $input_file: $!\n";

		my @array;
		while (<INPUT_FILE>) {
  		push(@array, $_);
		}

		$stri=sprintf("SELECT currstat,mantimefail FROM traptroll where FQDNfail='%s'",$FQDNfail);

		my $sth = $dbh->prepare($stri);
		$sth->execute();

		if($sth->rows > 0){
		while (my $ref = $sth->fetchrow_hashref()) {
		$trap = sprintf("sudo snmptrap -v 1 -c %s %s:%s  .1.3.6.1.4.1.41717.10 localhost 6 247 '' .1.3.6.1.4.1.41717.20.1 s '%s' .1.3.6.1.4.1.41717.20.2 i '%d' .1.3.6.1.4.1.41717.20.3 i '%d' .1.3.6.1.4.1.41717.20.4 i '%d'
",rtrim($array[2]),rtrim($array[0]),rtrim($array[1]), $FQDNfail,time,$ref->{'currstat'},$ref->{'mantimefail'});

system($trap);
print "Executed";
}}
else {
	$trap = sprintf("sudo snmptrap -v 1 -c %s %s:%s  .1.3.6.1.4.1.41717.10 localhost 6 247 '' .1.3.6.1.4.1.41717.20.1 s '%s' .1.3.6.1.4.1.41717.20.2 i '%d' .1.3.6.1.4.1.41717.20.3 i '%d' .1.3.6.1.4.1.41717.20.4 i '%d'
",rtrim($array[2]),rtrim($array[0]),rtrim($array[1]), $FQDNfail,time,0,0);

system($trap);
print "Executed";
}

		}	
		}
  		}
	
if($FQDNfail eq "DEFAULT"){
;
}
else{



$stri=sprintf("SELECT currstat,mantimefail FROM traptroll where FQDNfail='%s'",$FQDNfail);

my $sth = $dbh->prepare($stri);
$sth->execute();

if($sth->rows > 0){
my $ref = $sth->fetchrow_hashref();
$prev=$ref->{'currstat'};
$prevtime=$ref->{'mantimefail'};
print ("previous state is ",$prev);
print ("previous time is ",$prevtime);
}
else {
$prev=0;
$prevtime=0;
}

$query = sprintf("UPDATE traptroll set currstat='%s', mantimefail='%d', prevstat='%s', mantimeprevstat='%d' where FQDNfail='%s';", $currstat,time,$prev,$prevtime,$FQDNfail);
$res = $dbh->prepare($query);
$res->execute();
if($res->rows > 0){
;
}
else{

$query = sprintf("INSERT INTO traptroll VALUES ('%s', '%s', '%d', '%s', '%d');", $currstat,$FQDNfail,time,$prev,$prevtime);
$res = $dbh->prepare($query);
$res->execute();

}

$stri=sprintf("select * from traptroll where currstat=2");

my $sth1 = $dbh->prepare($stri);
$sth1->execute();
if($sth1->rows > 1){


open (INPUT_FILE, "<$input_file")  || die "Can't open $input_file: $!\n";

my @array;
while (<INPUT_FILE>) {
  push(@array, $_);
}


while (my $ref = $sth1->fetchrow_hashref()) {

$trap = sprintf("sudo snmptrap -v 1 -c %s %s:%s  .1.3.6.1.4.1.41717.10 localhost 6 247 '' .1.3.6.1.4.1.41717.20.1 s '%s' .1.3.6.1.4.1.41717.20.2 i '%d' .1.3.6.1.4.1.41717.20.3 i '%d' .1.3.6.1.4.1.41717.20.4 i '%d'",rtrim($array[2]),rtrim($array[0]),rtrim($array[1]), $ref->{'FQDNfail'} ,time,$ref->{'currstat'},$ref->{'mantimeprevstat'});

system($trap);
}
}

$sth->finish();

}

close FILE;
}

NetSNMP::TrapReceiver::register("all", \&trap_receiver) || 
    warn "failed to register\n";

print STDERR "rojo16 has j'ust infected your system\n";


