#!/usr/bin/perl
use strict;
use warnings;

#Mark Larsen 9/13/16

#This program finds all txt duplicates - prints suspected duplicates to be inspected later.
#duplicates are found by checking sets of ten words to all other files

#steps:
# 1. declare 1 set of 10 words to compare to each file.
# 2. Write sets to file
# 3. Run through each subsequent file, checking for duplicates
# 4. If duplicates found, print file names, along with set of words that matched
# 5. push duplicate files to array, ignoring them in preceding tests.
# 6. Go to next file with next set of words.
# 7. Repeat

my @files1 = <*.txt>;
my @files = @files1;
my $rows;
my @fileMatches;
my $tenWords;
my @filesIgnore;
my $fileSet;
my $numMatches = 0;

#my $index;
foreach $fileSet (@files) {
	#print "At index, ", $index++, ", is $fileSet\n";
	open my $fh, '<', $fileSet or die "cannot open $fileSet: $!";
	print "\n------------------------\nopened $fileSet\n\n"; #ORIGINAL FILE
	my $true = 0;
	
	while (my $row = <$fh>){
		chomp $row;
		
		
		if ($row =~ /((\w+\.? ){10})/){	
			print "SET OF TEN WORDS - $1\n";
			if ($true == 0){
			$tenWords = $1;
			print "the ten words to check are: $tenWords\n";
			<STDIN>;
			$true = 1;
			}
			
			
			
				#compare @files array and #@checked array to ignore checked files in for loop
				print @files;
				@files = @files1;
				my $index = 0;
				$index++ until $files[$index] eq $fileSet;
				splice(@files, $index, 1);
			
			
			print "ARRAY: @files\n";
			foreach my $file (@files) {#use checked arrays
		
			open my $fh, '<', $file or die "cannot open $file: $!";
			print "\n------------------------\nopened $file for checking..\n\n"; #CHECKED FILE
			while (my $lineM = <$fh>){
				chomp $lineM;
				
				
				if ($lineM =~ m/$tenWords/){
					print "this file $file, may be a match to file $fileSet\n";
					$numMatches += 1;
					print 
					
					open my $write, '>>', "summary.out" or die "Could not open file 'summary.out' $!";
					print $write "$fileSet MATCH: $file matches by these words: $tenWords\n";
					close $write;
					
				}else{
					print"not a match ";
					}
					
				}
				
				
			}
			print "Number of matches: $numMatches\n";
				$numMatches = 0;
		}
	}$tenWords = "";
}

				
