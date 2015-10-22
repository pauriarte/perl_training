#!/usr/bin/perl
use v5.18;

say "Insert integer number n from diapason 2..1000000:";
my $number = <STDIN>;
my $start = time();
if ($number >= 2 && $number <= 1000000 && $number =~ /\d+/){
	my @tmp;
	my $it = 0;
	while($it < $number){
		@tmp[$it] = 1;
		$it++;
	}

	my $root = sqrt($number);

	LABEL:for(my $i = 2; $i <= $root; $i++){
		next LABEL if(@tmp[$i]!= 1); 
		for( my $j = $i*$i; $j < $number; $j+=$i){
			if($tmp[$j] == 1){
				$tmp[$j] = 0;		
			}
		}	
	}

	my $j = 0;
	my @primos;

	for(my $i = 1; $i < $number; $i++){
		if($tmp[$i] == 1){
			@primos[$j++] = $i." ";
		}
	}

	say @primos;
}
else{
	die ("Bad input\n");
}

my $end = time();

say $end-$start ." seconds"; 



