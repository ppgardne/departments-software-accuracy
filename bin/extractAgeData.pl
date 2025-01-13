#!/usr/bin/perl 

# script to answer reviewer question about potential confounding by age of tools

use warnings;
use strict;

my $inFile  = "table2.tsv"; 
my $outFile = "yearPublishedByField.tsv";

#Included fields:
my $fieldsFile = "mean-wins-cis.tsv";
my %include;
open(IN, "<  $fieldsFile") or die "FATAL: failed to open  [$fieldsFile]\n[$!]";
while(my $in = <IN>){
    my @in = split(/\t/, $in);
    if($in[0] eq 'fieldSpecific'){
	$include{$in[1]}=1;
    }
    
}
close(IN);

open(IN, "<  $inFile") or die "FATAL: failed to open  [$inFile]\n[$!]";
open(UT, "> $outFile") or die "FATAL: failed to open [$outFile]\n[$!]";

print UT "tool\tyearPublished\tgeneralField\tspecificField\n";
while(my $in = <IN>){
    next if $in =~ /^tool/;
    my @in = split(/\t/, $in);

    #skip missing data
    next if (not defined($in[1]) or not defined($in[20]) or not defined($in[21]));
    next if ($in[1] eq 'NA' or $in[20] eq 'NA');
    next if (length($in[20]) == 0 or length($in[21]) == 0 );
    
    #deal with multiple dates:
    if($in[1] =~ /;/){
	my @date = split(/;/, $in[1]);
	$in[1] = $date[1];
    }

    $in[21] =~ s/\d{2}\.\d{4}\s//g;
    $in[20] =~ s/;\s/;/g;
    $in[21] =~ s/;\s/;/g;
    $in[20] =~ s/\ssci/\.sci/g;
    $in[21] =~ s/\ssci/\.sci/g;
    $in[20] =~ s/Mathematics and Statistics/Maths\/Stats/g;
    $in[21] =~ s/Molecular\s/Molecular./g;
    $in[21] =~ s/Medical informatics/Medical.informatics/g;
    $in[20] =~ s/\s//g;
    $in[21] =~ s/\s//g;
    my $prnt  = '';
    
    #deal with multifield authors:
    if($in[21] =~ /;/ and $in[20] !~ /;/){
	my @spcField = split(/;/, $in[21]);
	#my @genField = split(/;/, $in[20]);
	$prnt .= "$in[0]\t$in[1]\t$in[20]\t$spcField[0]\n" if defined( $include{$spcField[0]} );
	$prnt .= "$in[0]\t$in[1]\t$in[20]\t$spcField[1]\n" if defined( $include{$spcField[1]} );

    }
    elsif($in[20] =~ /;/){
	my @spcField = split(/;/, $in[21]);
	my @genField = split(/;/, $in[20]);
	$prnt  = '';
	$prnt  = "$in[0]\t$in[1]\t$genField[0]\t$spcField[0]\n" if defined( $include{$spcField[0]} );
	$prnt .= "$in[0]\t$in[1]\t$genField[1]\t$spcField[1]\n" if defined( $include{$spcField[1]} );
    }
    else {
	$prnt = "$in[0]\t$in[1]\t$in[20]\t$in[21]\n" if defined( $include{$in[21]} );
    }
    print UT $prnt;
    
    
}
close(IN);
close(UT);








