#!/usr/bin/perl
use v5.18;
say "Insert integer number n from diapason 2..1000000:";
my $number = <STDIN>;

if ($number >= 2 and $number <= 1000000 && $number =~ /\d+/){
	my $charm;
	for(my $val = 1; $val <= $number; $val++){
		if($val % 2 != 0 || $val == 2){
			$charm.= $val." ";
		}
	}
	print "$charm \n";
}
else{
	die ("Bad input\n");
}
 
