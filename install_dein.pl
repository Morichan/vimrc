use strict;
use warnings;

use File::Path 'mkpath';

my $home_dir;
if (index($^O, "Win") >= 0) {
    chomp($home_dir = `echo %homepath%`);
} else {
    $home_dir = $ENV{HOME};
}

my $dir_name = "$home_dir/.vim/dein/repos/github.com/Shougo";

print "> mkdir $dir_name\n";
mkpath $dir_name;

print "> git clone https://github.com/Shougo/dein.vim.git $dir_name/dein.vim";
system "git clone https://github.com/Shougo/dein.vim.git $dir_name/dein.vim";

exit;
