#!/usr/bin/perl

use strict;
use NetSNMP::agent (':all');
use NetSNMP::ASN qw(ASN_INTEGER);

#####File manipulation
my @mainarray;
my $T;
my $i;
my $filename="/home/proj/counters.conf"; 
our $ansout = "stale";


if (open(my $fh, '<:encoding(UTF-8)', $filename)) {
$i = 0;

while (my $row = <$fh>) {
chomp $row;

$mainarray[$i] = $row ;
$i = $i+1;
}
close($fh);
}

else {
      warn "Could not open file '$filename' $!";
}

$i = $i+1;

#####Start of SNMP code

sub time_handler {
  my ($handler, $registration_info, $request_info, $requests) = @_;
  my $tim = time;
   my $oid = $requests->getOID();
    if ($request_info->getMode() == MODE_GET) {
      if ($oid == new NetSNMP::OID(".1.3.6.1.4.1.4171.40.1.0")) {
        $requests->setValue(ASN_INTEGER, "$tim");
      }
    }
 }


my $agent1 = new NetSNMP::agent();
$agent1->register("rojo16", ".1.3.6.1.4.1.4171.40.1",
                 \&time_handler);

my $id;
my $oid_in;
my $oid_in2;
my $oid_out;

sub counter_handler {
  my ($handler, $registration_info, $request_info, $requests) = @_;

   my $oid = $requests->getOID();
my $x=2;
print $x;
print $i;
print @mainarray[0];
    if ($request_info->getMode() == MODE_GET) {
for($x=2;$x<=$i;$x++){
my @array = split ',',@mainarray[$x-2];
my $id =  $array[0];
my $C =  $array[1];
$T = time;


$oid_in = "1.3.6.1.4.1.4171.40.".$x.".0";
$oid_in2 = "1.3.6.1.4.1.4171.40.".$x.".1";

my $answer = ($C*$T);
$answer = $answer & 2147483647;
if($answer == 2147483647)
{
$answer = 0;
}


      if ($oid == new NetSNMP::OID("$oid_in")) {
        $requests->setValue(ASN_INTEGER, "$answer");
      }
      elsif ($oid == new NetSNMP::OID("$oid_in2")) {
        $requests->setValue(ASN_INTEGER, $C);
      }
    }
 }
}

my $agent = new NetSNMP::agent(Name=>"rojo16");
$agent->register("rojo16","1.3.6.1.4.1.4171.40",\&counter_handler);
