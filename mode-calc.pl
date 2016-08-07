#!/usr/bin/perl
#
## firexfly@users.noreply.github.com
## mode-calc
#
# New BSD License (http://www.opensource.org/licenses/BSD-3-Clause)
# Copyright (c) 2016, FireXfly
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without modification, 
# are permitted provided that the following conditions are met:
#
#	1. Redistributions of source code must retain the above copyright notice, this 
#	    list of conditions and the following disclaimer.
#
#	2. Redistributions in binary form must reproduce the above copyright notice, 
#	    this list of conditions and the following disclaimer in the documentation 
#	    and/or other materials provided with the distribution.
#
#	3. Neither the name of the copyright holder nor the names of its contributors 
#	    may be used to endorse or promote products derived from this software 
#	    without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS 
# OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY 
# AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR 
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL 
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, 
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER 
# IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT 
# OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

use strict;
use 5.010;




sub numerically {$a <=> $b} #Numeric sort sub

### data input ###
sub get_data {
	my @fields;
	my @all_fields;
	while (<>) {
		chomp;
		if (not length $_) { #No input
			print "No input, retry.\n";
			return get_data();
		}
		if (/[^0-9 ]/) { #Unexpected characters in data set
        		print "Non numeric data in data set, retry.\n";
        		return get_data();
		}
		@fields = split; #Values stored in array
		foreach (@fields) { #Cater for input from multiple files
			push @all_fields, $_;
		}
	}
@all_fields;
}
#########################

#### Table ####################
if (@ARGV == 0) {
        print "Please enter data set below, separated by spaces:\n";
} elsif (@ARGV != 0) {
	foreach (@ARGV) {
		if (! -e $_) { #File does not exist
			die "Error: No such file as \'$_\'\n";
		} elsif (-z $_) { #File has zero size
			die "Error: File \'$_\' is empty\n";
		}
	}
}

my @input = &get_data(); #Get data from sub
my $indent;
my %values;

foreach (@input) {
	$values{$_} ++; #Values and no. of occurrences stored in hash
	if (length $_ > $indent) {
		$indent = length $_;
	}
}
foreach (sort numerically keys %values) {
	printf "%${indent}d\t%s\t%d\n", $_, '=>', $values{$_};
}
print "\n";

#### Print mode or modes ###############
my @mode; #Mode candidate
my $occurrences; #Mode occurrences

foreach (sort keys %values) {
	if ($values{$_} > $occurrences) {
		$occurrences = $values{$_}; #New mode candidate occurrences
		@mode = ( ); #Empty list
		$mode[0] = $_; #New mode candidate
	} elsif ($values{$_} == $occurrences) {
		push @mode, $_; #Multiple mode candidates
	}
}

if (scalar @mode == scalar keys %values) {
	print "There is no mode.\n";
} else {
	print "The mode is: @mode\n";
}

print "-----------------------------------------\n";
##########################################
