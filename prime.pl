#!/usr/bin/perl
use v5.18;
say "Insert integer number n from diapason 2..1000000:";
my $number = <STDIN>;

#say sqrt $number;

my $start = time();
if ($number >= 2 and $number <= 1000000 && $number =~ /\d+/){
	my $chain.="1 ";
	my $count;
	for(my $i = 1; $i < $number; $i++){
		$count = 0;
		for(my $k = 1; $k < $number; $k++){
			if($i eq $k || $i % $k eq 0){
				$count++;
			}
		}
		if($count eq 2){
			$chain.= $i." ";
		}	
	}
	print "$chain \n";
}
else{
	die ("Bad input\n");
}

my $end = time();

say "$end-$start seconds"; 
