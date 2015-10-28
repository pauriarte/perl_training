#!/usr/bin/perl
use v5.14;
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

#-------------------Class Rectangle--------------------------
package Rectangle;
use Data::Dumper;

our @ISA = qw( Figure );

sub new {
	#my $class = shift;
	#my ($color, $coord) = @_;
	#print Dumper /$coord;
	#my $this = $class->SUPER::new($color, $coord);

	my $this=shift; #Cogemos la clase que somos o una referencia a la clase (si soy un objeto)
	my ($color, $coord) = @_;
	#print Dumper \$coord;
	my $class = ref($this) || $this; #Averiguo la clase a la que pertenezco
	my $self=$class->Figure::new($color,$coord); #Inicializamos las propiedades con las usadas en Coche
	#$self->{PRECIO} = undef; #No se indica ningun precio
	bless $self, $class; #Se crea la clase
	return ($self); #Devolvemos la clase recién construida
}

sub calculateArea(){
	my @coord = @{shift->{'coord'}};
	my ($x1,$x2,$x3,$x4,$y1,$y2,$y3,$y4) = ($coord[0]->get_x,$coord[1]->get_x,$coord[2]->get_x,$coord[3]->get_x,$coord[0]->get_y,$coord[1]->get_y,$coord[2]->get_y,$coord[3]->get_y);
	my $dist1 = sqrt (($x2-$x1)**2 + ($y2-$y1)**2);
	my $dist2 = sqrt (($x4-$x3)**2 + ($y4-$y3)**2);
	say $dist1;
	say $dist2;
	return $dist1 * $dist2;
}


1;

#-------------------Class Square--------------------------
package Square;
use Data::Dumper;

our @ISA = qw( Rectangle );

sub new {
	#my $class = shift;
	#my ($color, $coord) = @_;
	#print Dumper /$coord;
	#my $this = $class->SUPER::new($color, $coord);

	my $this=shift; #Cogemos la clase que somos o una referencia a la clase (si soy un objeto)
	my ($color, $coord) = @_;
	#print Dumper \$coord;
	my $class = ref($this) || $this; #Averiguo la clase a la que pertenezco
	my $self=$class->Figure::new($color,$coord); #Inicializamos las propiedades con las usadas en Coche
	#$self->{PRECIO} = undef; #No se indica ningun precio
	bless $self, $class; #Se crea la clase
	return ($self); #Devolvemos la clase recién construida
}

sub calculateArea(){
	my @coord = @{shift->{'coord'}};
	my ($x1,$x2,$x3,$x4,$y1,$y2,$y3,$y4) = ($coord[0]->get_x,$coord[1]->get_x,$coord[2]->get_x,$coord[3]->get_x,$coord[0]->get_y,$coord[1]->get_y,$coord[2]->get_y,$coord[3]->get_y);
	my $dist1 = sqrt (($x2-$x1)**2 + ($y2-$y1)**2);
	my $dist2 = sqrt (($x4-$x3)**2 + ($y4-$y3)**2);
	say $dist1;
	say $dist2;
	return $dist1 * $dist2;
}


1;


#-------------------Class main--------------------------
package main;

use Data::Dumper qw(Dumper);

my $c1 = Coordinate->new(1,3);
my $c2 = Coordinate->new(1,8);
my $c3 = Coordinate->new(6,3);
my $c4 = Coordinate->new(6,8);



my $coordinates = [$c1, $c2, $c3, $c4];
#print Dumper \@coordinates;

#my $f = Figure->new('blue', $coordinates);
my $r = Rectangle->new('blue', $coordinates);
#$c1->set_x(333);
#say $c1->get_x;
#say $c1->get_y;
#$f->set_color("red");
#say $f->get_color;
#my @cor = $f->get_coord;
#print Dumper \$cor[1]->get_x;
#print Dumper \$cor[1]->get_y;
my $area = $r->calculateArea();
$r->set_color("orange");
say $r->get_color;
say $area;





1;
