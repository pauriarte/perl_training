#!/usr/bin/perl
use v5.18;

say "Please, enter 1 line of text: ";

my $text = <STDIN>;
#my @text = split(" ",$text);


say "Please, enter space separated strings to match and replace (one pair per line).";

say "Empty line will interrupt input and start execution:";

my (%replace, $line);

do {
	$line = <STDIN>;
	my ($word, $wreplace) = split(" ", $line);
	$replace{$word}= $wreplace;


} until !defined($line) || $line eq "\n";

my $exp = join "|", keys %replace;

$text =~ s/($exp)/$replace{$1}/cg;

say $text;
