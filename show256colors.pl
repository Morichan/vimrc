#!/usr/bin/perl

use strict;
use warnings;

my $fg = "\x1b[38;5;";
my $bg = "\x1b[48;5;";
my $rs = "\x1b[0m";

foreach my $row (0..31) {
    foreach my $column (0..7) {
        print generate_color_text($row * 8 + $column);
    }
    print "\n";
}

sub generate_color_text {
    my ($color) = @_;
    my $number = sprintf '%3d', $color;
    return "${bg}${color}m ${number} ${rs} ${fg}${color}m${number}${rs} ";
}

