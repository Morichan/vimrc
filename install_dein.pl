use strict;
use warnings;

use Cwd 'getcwd';
use File::Path 'mkpath';

my $home_dir;
my $vim_dotfiles_root_dir = getcwd;
if (index($^O, "Win") >= 0) {
    chomp($home_dir = `echo %homepath%`);
} else {
    $home_dir = $ENV{HOME};
}

my $dir_name = "$vim_dotfiles_root_dir/.vim/dein/repos/github.com/Shougo";

print "> mkdir $dir_name\n";
mkpath $dir_name;

print "> git clone https://github.com/Shougo/dein.vim.git $dir_name/dein.vim";
system "git clone https://github.com/Shougo/dein.vim.git $dir_name/dein.vim";

$dir_name = "$vim_dotfiles_root_dir/.vim/undo";

print "> mkdir $dir_name\n";
mkpath $dir_name;

exit;
