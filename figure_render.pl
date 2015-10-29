#!/usr/bin/perl
use v5.14;
use Data::Dumper;
use GD::Simple;
use DBI;


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

sub get_coord_str {
	my $this = shift;
	my $coord_str.=$this->{x}.",".$this->{x};
	
	return $coord_str;
}

1;
#-------------------Class Figure--------------------------
package Figure;
use Data::Dumper;


sub new {
	my $class = shift;
	my ($coord) = @_;

	#print	Dumper \$coord;

	my $this = bless {}, $class;

	$this->{'color'} = undef;
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
use GD::Simple;


our @ISA = qw( Figure );

sub new {
	my $this=shift; #Cogemos la clase que somos o una referencia a la clase (si soy un objeto)
	my ($coord) = @_;
	#print Dumper \$coord;
	my $class = ref($this) || $this; #Averiguo la clase a la que pertenezco
	my $self=$class->SUPER::new($coord); #Inicializamos las propiedades con las usadas en Figure
    	$self->{'color'} = "red";

	bless $self, $class; #Se crea la clase
	return ($self); #Devolvemos la clase recién construida
}

sub calculateArea(){
	my @coord = @{shift->{'coord'}};
	my ($x1,$x2,$x3,$y1,$y2,$y3) = ($coord[0]->get_x,$coord[1]->get_x,$coord[2]->get_x,$coord[0]->get_y,$coord[1]->get_y,$coord[2]->get_y);
	my $dist1 = sqrt (($x2-$x1)**2 + ($y2-$y1)**2);
	my $dist2 = sqrt (($x3-$x2)**2 + ($y3-$y2)**2);
	#say $dist1;
	#say $dist2;
	return $dist1 * $dist2;
}

sub draw(){
    my $img = GD::Simple->new(200, 300);
    my $this = shift;   
    $img->bgcolor($this->{'color'});
    $img->fgcolor($this->{'color'});
	my @coord = @{$this->{'coord'}};
	my ($x1,$x2,$y1,$y2) = ($coord[0]->get_x,$coord[2]->get_x,$coord[0]->get_y,$coord[2]->get_y);

    $img->rectangle($x1,$y1,$x2,$y2);
    open my $out, '>', 'rectangle_img.png' or die;
    binmode $out;
    print $out $img->png;
}


1;

#-------------------Class Square--------------------------
package Square;
use Data::Dumper;

our @ISA = qw( Rectangle );

sub new {
	my $this=shift; #Cogemos la clase que somos o una referencia a la clase (si soy un objeto)
	my ($coord) = @_;
	#print Dumper \$coord;
	my $class = ref($this) || $this; #Averiguo la clase a la que pertenezco
	my $self=$class->SUPER::new($coord); #Inicializamos las propiedades con las usadas en Rectangle
    	$self->{'color'} = "blue";
	bless $self, $class; #Se crea la clase
	return ($self); #Devolvemos la clase recién construida
}

sub calculateArea(){
	my @coord = @{shift->{'coord'}};
	my ($x1,$x2,$y1,$y2) = ($coord[0]->get_x,$coord[1]->get_x,$coord[0]->get_y,$coord[1]->get_y);
	my $dist = sqrt (($x2-$x1)**2 + ($y2-$y1)**2);
	#say $dist;
	return $dist**2;
}

sub draw(){
    my $img = GD::Simple->new(200, 300);
    my $this = shift;   
    $img->bgcolor($this->{'color'});
    $img->fgcolor($this->{'color'});
	my @coord = @{$this->{'coord'}};
	my ($x1,$x2,$y1,$y2) = ($coord[0]->get_x,$coord[2]->get_x,$coord[0]->get_y,$coord[2]->get_y);

    $img->rectangle($x1,$y1,$x2,$y2);
    open my $out, '>', 'square_img.png' or die;
    binmode $out;
    print $out $img->png;
}

1;

#-------------------Class Circle--------------------------
package Circle;

use Math::Trig;
use Data::Dumper;

our @ISA = qw( Figure );

sub new {
	my $this=shift; #Cogemos la clase que somos o una referencia a la clase (si soy un objeto)
	my ($coord) = @_;
	#print Dumper \$coord;
	my $class = ref($this) || $this; #Averiguo la clase a la que pertenezco
	my $self=$class->SUPER::new($coord); #Inicializamos las propiedades con las usadas en Figure
    	$self->{'color'} = "green";
	bless $self, $class; #Se crea la clase
	return ($self); #Devolvemos la clase recién construida
}

sub calculateArea(){
	my @coord = @{shift->{'coord'}};
	my ($x1,$x2,$y1,$y2) = ($coord[0]->get_x,$coord[1]->get_x,$coord[0]->get_y,$coord[1]->get_y);
	my $dist = sqrt (($x2-$x1)**2 + ($y2-$y1)**2);
	#say "Pi: ".pi;
	return pi*$dist**2;
}

sub draw(){
    my $img = GD::Simple->new(200, 300);
    my $this = shift;   
    #$img->bgcolor($this->{'color'});
    #$img->fgcolor($this->{'color'});
    #$img->moveTo(100,50);
	my @coord = @{$this->{'coord'}};
	my ($x1,$x2,$y1,$y2) = ($coord[0]->get_x,$coord[1]->get_x,$coord[0]->get_y,$coord[1]->get_y);
   	my $dist = sqrt (($x2-$x1)**2 + ($y2-$y1)**2); 
    $img->filledArc($x1,$y1,$dist,$dist,0,360,$img->colorAllocate(46,139,87));
    open my $out, '>', 'circle_img.png' or die;
    binmode $out;
    print $out $img->png;
}

1;

#-------------------Class Triangle--------------------------
package Triangle;

use Data::Dumper;

our @ISA = qw( Figure );

sub new {
	my $this=shift; #Cogemos la clase que somos o una referencia a la clase (si soy un objeto)
	my ($coord) = @_;
	#print Dumper \$coord;
	my $class = ref($this) || $this; #Averiguo la clase a la que pertenezco
	my $self=$class->SUPER::new($coord); #Inicializamos las propiedades con las usadas en Figure
    $self->{'color'} = "yellow";
	bless $self, $class; #Se crea la clase
	return ($self); #Devolvemos la clase recién construida
}

sub calculateArea(){
	my @coord = @{shift->{'coord'}};
	my ($x1,$x2,$y1,$y2) = ($coord[0]->get_x,$coord[1]->get_x,$coord[0]->get_y,$coord[1]->get_y);
	my $dist = sqrt (($x2-$x1)**2 + ($y2-$y1)**2);
	#say $dist;
	return (sqrt(3)/4)*$dist**2;
}

sub draw(){
    my $img = GD::Simple->new(200, 300);
    my $poly = GD::Polygon->new();

    my $this = shift;   

    
    $img->bgcolor($this->{'color'});
    $img->fgcolor($this->{'color'});
	
    my @coord = @{$this->{'coord'}};
    my ($x1,$x2,$y1,$y2) = ($coord[0]->get_x,$coord[1]->get_x,$coord[0]->get_y,$coord[1]->get_y);
    
    my $x3 = $x1 + $x2 - (sqrt(3) * ($y1 - $y2));
    my $y3 = $y1 + $y2 + (sqrt(3) * ($x1 - $x2));

    $poly->addPt($x1,$y1);
    $poly->addPt($x2,$y2);
    $poly->addPt($x3,$y3);
    $img->polygon($poly);
    open my $out, '>', 'triangle_img.png' or die;
    binmode $out;
    print $out $img->png;
}




1;
#-------------------Class Controller--------------------------

package Controller;

sub new {
	my $class = shift;
    
	my $this = bless {}, $class;
	my $dbh = DBI->connect('DBI:mysql:Render', 'pauriarte', 'r00t'
	           ) || die "Could not connect to database: $DBI::errstr";
	
	$this->{'dbh'}= $dbh;
	$this->{'id'}=1;
	
	$dbh->do('CREATE TABLE IF NOT EXISTS Figures (id INT, name VARCHAR(50),type VARCHAR(100),coordinates VARCHAR(100))');
	
	my $insert = $dbh->prepare(q{INSERT INTO Figures (id, name, type,coordinates) VALUES (?, ?, ?, ?)}) or die $dbh->errstr;
	$this->{'insert'}= $insert;
	
	my $select = $dbh->prepare(q{SELECT name, coordinates FROM Figures WHERE type = ?}) or die $dbh->errstr;
	$this->{'select'}= $select;
	return $this;
}

sub createFigure {
    my $this = shift;
    my $name = shift;
    my $coord = shift;
        
    my $figure;  
    my $insert = $this->{'insert'};
    my $id=$this->{'id'};
    
    if($name =~ /Rectangle|Square|Circle|Triangle|rectangle|square|circle|triangle/){
        
        $figure = $name->new($coord);
        
        my $coordinates;
        for my $val ($coord){
	  $coordinates.=$val->get_coord_str." ";
        }
       
        $insert->execute($id, $name."_".$id, $name, $coordinates) or die $dbh->errstr;
    }
    else
    {
        default {die "No figure named $name."};
    }

    return $figure;
}

sub listFigure{
  my $this = shift;
  my $name = shift;
  my $select = $this->{'select'};
 
  $select->execute($name) or die $dbh->errstr;
  
  while ( @row = $select->fetchrow_array ) {
    print "@row\n";
  }
}


1;

#-------------------Class main--------------------------
package main;

use Data::Dumper qw(Dumper);

my $line;

my $controller = Controller->new();

my @figures;

say "1-Example: create Rectangle|Square|Circle|Triangle x1,y1 x2,y2 x3,y3 x4,y4";
say "2-To continue enter new figure press enter and repeat step 1. To finish insert figure, press enter with empty line.";
do{
    $line = <STDIN>;
    #say $line;
    my @parameters=split(" ",$line);
   # print Dumper \@parameters;
    my $command = shift @parameters;
    my $name = shift @parameters;
    
    if($command =~/create/){
	my ($x,$y);
	my @array_coord;
	for my $point (@parameters){
        ($x,$y)=split(",",$point);
        #say "x: $x y:$y";
        my $coord = Coordinate->new($x,$y);
        push @array_coord, $coord;
	}
    
        my $figure = $controller->createFigure($name,\@array_coord);
        push @figures,$figure;
    }
    elsif($command =~/list/){
	$controller->listFigure($name);
    }

} until !defined($line) || $line eq "\n";

for my $fig (@figures){
   # say $fig->get_color;
    say $fig->calculateArea;
    $fig->draw;
}


1;
