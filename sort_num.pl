#!/usr/bin/perl
use v5.18;
use Data::Dumper;

my %one_num_for = (
zero => 0,
one => 1,
two => 2,
three => 3,
four => 4,
five => 5,
six => 6,
seven => 7,
eight => 8,
nine => 9,
ten => 10,
eleven => 11,
twelve => 12,
thirteen => 13,
fourteen => 14,
fifteen => 15,
sixteen => 16,
seventeen => 17,
eighteen => 18,
nineteen => 19,
twenty => 20,
thirty => 30,
forty => 40,
fifty => 50,
sixty => 60,
seventy => 70,
eighty => 80,
ninety => 90
);

my $exp_num = join "|", keys %one_num_for;

my %others = (
hundred => 100,
thousand => 1000
);
my $exp_others = join "|",keys %others;


open(NUMBERS, "<:utf8", "numbers") || die "Can't open numbers: $!\n";
binmode(STDOUT, ':utf8');

my (%str_numbers,@digits,$flag);

while( my $line = <NUMBERS> ) {
	@digits = split(" ",$line);
	$flag = 0;
	my ($numberA,$numberB);
	for my $digit (@digits){
		if ($digit =~ /hundred/){
			$digit =~ s/($digit)/$others{$1}/g;

			if($flag){
				$numberB *= $digit;
			}
			else{
				$numberA *= $digit;
			}	
		}

		if ($digit =~ /thousand/){
			$digit =~ s/($digit)/$others{$1}/g;

			if($flag){
				$numberB *= $digit;
			}
			else{
				$numberA *= $digit;
				
			}	
			$flag = 1;			
		}

		if ($digit =~ $exp_num){
			$digit =~ s/($digit)/$one_num_for{$1}/g;
			
			if($flag){
				$numberB += $digit;
			}
			else{
				$numberA += $digit; 
			}
		}
	}
	if ($numberB){ $numberA += $numberB };	
	chop($str_numbers{$numberA} = $line);
}

for my $key (reverse sort {$a <=> $b} keys %str_numbers){
	say $str_numbers{$key};
	say $key;
}
	
 
