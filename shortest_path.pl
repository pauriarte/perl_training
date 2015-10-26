#!/usr/bin/perl
use v5.18;
use Data::Dumper;

my $arg = <@ARGV>;
open(NODES, "<:utf8", $arg) || die "Can't open numbers: $!\n";
binmode(STDOUT, ':utf8');

my ($begin,$end) = split(" ",<NODES>); 

my (%graph, $final, $path_size);
while(my $line = <NODES>){
	my ($name,$neighbors) = split(" ",$line);
	if(!exists $graph{$name}){
		$graph{$name} = [];
	}	
	push @graph{$name}, $neighbors;
}

for my $a (keys %graph){
	if($a =~ /$begin/){
		my $nodes = \@graph{$a};

		say $graph{$a}[0];
		say @{$nodes};
	}
}



print Dumper \%graph;

