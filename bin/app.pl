#!/usr/bin/env perl

use Dancer;

use Block::Create;

use strict;
use warnings;
use utf8;

# Variables

my $dir = "/tmp";

get '/create/:ticket/:ip' => sub {
     
    my $ip = param('ip');
    my $ticket = param('ticket');

    if($ip !~ '^\d+\.\d+\.\d+\.\d+$' || $ticket !~ '^\d+$') {
	return "ERROR";
    }
    my $hash = `openssl rand 64 | openssl md5`;

    chomp($hash);

    open(FILE,">$dir/$hash");
    print FILE $ip." " . $ticket ."\n";
    close(FILE);

    return $hash;
};

dance;
