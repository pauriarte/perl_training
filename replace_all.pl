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

my $lotr = join "|", keys %replace;
$lotr = qr/$lotr/;

$text =~ s/($lotr)/$replace{$1}/cg;

say $text;
