#!/usr/bin/perl
use v5.18;
use Data::Dumper;
use Paths::Graph;

my $arg = <@ARGV>;
open(NODES, "<:utf8", $arg) || die "Can't open numbers: $!\n";
binmode(STDOUT, ':utf8');

my ($begin,$end) = split(" ",<NODES>); 

my %graph;
while(my $line = <NODES>){
	my ($name,$neighbor) = split(" ",$line);
	$graph{$name}{$neighbor}=1;
}

my $gr = Paths::Graph->new(-origin=>$begin,-destiny=>$end,-graph=>\%graph);

my @paths = $gr->shortest_path();

my $cost;
for my $path (@paths) {
	$cost = $gr->get_path_cost(@$path);
}

if (not $cost){
	die"-1\n";
}
else
{
	say $cost;
}



