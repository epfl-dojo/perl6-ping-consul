#!/usr/bin/env perl6
use JSON::Tiny;
my $fh = q:x"consul-cli --consul=10.92.103.53:8500  catalog nodes";
my $array=from-json($fh);

my @exitcode_promises;
for @$array -> $i {
  my $ip = $i.{"Address"};
  push @exitcode_promises,  start shell "ping -c 3 $ip > /dev/null ";
}

my @exitcodes = await @exitcode_promises;
say @exitcodes;


