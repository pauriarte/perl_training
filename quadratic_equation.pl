#!/usr/bin/perl
use v5.18;
use Scalar::Util 'looks_like_number';

my ($a, $b, $c) = @ARGV;

if((looks_like_number($a))&&(looks_like_number($b) || $b eq "")
 &&(looks_like_number($c) || $c eq ""))
{
	my ($part1, $x1, $x2);

	eval{
		$part1 = sqrt(($b**2)-(4*$a*$c));
		my $part2 = 2*$a;
		$x1 = (-$b+ $part1)/$part2;
		$x2 = (-$b- $part1)/$part2;
	};

	if($@){
		#print STDERR "No real solutions\n";
		die ("No real solutions\n");
	}
	else{
	
		print STDOUT "$x1 $x2\n";
		exit;
	}
}
else{
	#print STDERR "Bad input\n";
	die ("Bad input\n");
}












