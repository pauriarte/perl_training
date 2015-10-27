#!/usr/bin/perl
use v5.18;
use Data::Dumper;

#-------------------Class Coordinate--------------------------
package Coordinate;

sub new {
	my $class = shift;
	my ($x,$y) = @_;
	my $this = bless {}, $class;

	$this->{"x"} = $x;
	$this->{"y"} = $y;
	return $this;
}

sub get_x {
   	return shift->{x};
}

sub set_x {
	   my $this = shift;
	   $this->{x} = shift || 0;
}

sub get_y {
   	return shift->{y};
}

sub set_y {
	   my $this = shift;
	   $this->{y} = shift || 0;
}

1;
#-------------------Class Figure--------------------------
package Figure;
use Data::Dumper;

sub new {
	my $class = shift;
	my ($color, $coord) = @_;

	#print	Dumper \$coord;

	my $this = bless {}, $class;

	$this->{'color'} = $color;
	$this->{'coord'} = $coord;
	return $this;
}

sub get_coord {
   	return @{shift->{'coord'}};
}

sub get_color {
   	return shift->{'color'};
}
sub set_color{
	my $this = shift;
	$this->{'color'} = shift || 0;
}

1;

#-------------------Class Figure--------------------------
package Rectangle;
use Data::Dumper;

our @ISA = qw( Figure );

sub new {
	my $class = shift;
	my ($color, $coord) = @_;
	$this = $class->SUPER::new($color, $coord);
}

sub calculateArea(){
	@coord = @{shift->{'coord'};
	print Dumper \@coord;
	return $this;
}


1;


#-------------------Class main--------------------------
package main;

use Data::Dumper qw(Dumper);

my $c1 = Coordinate->new(56,3);
my $c2 = Coordinate->new(20,30);
my $c3 = Coordinate->new(34,34);
my $c4 = Coordinate->new(56,3);



my @coordinates = ($c1, $c2, $c3, $c4);
#print Dumper \@coordinates;

#my $f = Figure->new('blue', \@coordinates);
my $r = Rectangle->new('blue', \@coordinates);
#$c1->set_x(333);
#say $c1->get_x;
#say $c1->get_y;
#$f->set_color("red");
#say $f->get_color;
#my @cor = $f->get_coord;
#print Dumper \$cor[1]->get_x;
#print Dumper \$cor[1]->get_y;
$r->calculateArea();





1;
