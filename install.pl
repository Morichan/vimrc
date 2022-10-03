#!/usr/bin/perl

use strict;
use warnings;
use feature ":5.10";
use File::Copy "move";
use File::Which "which";
use File::Spec;
use FindBin;
use utf8;
use open ":utf8";
use Encode "encode";
binmode STDIN, ":encoding(utf-8)";
binmode STDOUT, ":encoding(utf-8)";
binmode STDERR, ":encoding(utf-8)";


my $vimrc_description = "Morichan's vimrc file";
my $vimrc_file_path = &get_vimrc_file_path();

&backup_vimrc_file($vimrc_file_path, $vimrc_description);
&generate_vimrc_file($vimrc_file_path, $vimrc_description);


sub get_vimrc_file_path {
    my $file_name = &is_windows_os() ? "vimrc" : ".vimrc";
    my $path = &is_windows_os() ? which "vim" : $ENV{HOME};
    my ($volume, $directory) = File::Spec->splitpath($path, !&is_windows_os());

    return File::Spec->catpath(
        $volume,
        File::Spec->catdir(File::Spec->splitdir($directory)),
        $file_name
    );
}


sub is_windows_os {
    return index($^O, "Win") >= 0;
}


sub backup_vimrc_file {
    my ($file_path, $description) = @_;
    my $changed = $file_path . "_backup_" . &get_today_for_file_name_suffix();
    my $encoded_code = &is_windows_os() ? "CP932" : "UTF-8";

    if (-f $file_path) {
        open(my $fh, "<", encode($encoded_code, $file_path)) or die "Error: $!";
        my @lines_no_encoded = <$fh>;
        say "Info: $file_path is generated by this script." if grep { $_ =~ /$description/ } @lines_no_encoded;
        close($fh);

        say "> mv $file_path $changed";
        move($file_path, $changed);
    } elsif (glob $file_path . "_backup_*") {
        say "Info: $file_path is already backed up.";
    } else {
        say "Error: $file_path is not found.";
        exit 1;
    }
}


sub generate_vimrc_file {
    my ($file_path, $description) = @_;
    my $encoded_code = &is_windows_os() ? "CP932" : "UTF-8";
    my $this_script_directory_path = File::Spec->catdir(File::Spec->splitdir($FindBin::Bin));
    my ($volume, $directory) = File::Spec->splitpath($this_script_directory_path, 1);
    $directory = File::Spec->catdir(File::Spec->splitdir($directory));
    my $readme_path = File::Spec->catpath($volume, $directory, "README.md");
    my $rc_path = File::Spec->catpath($volume, File::Spec->catdir($directory, "rc"));

    say "> cat << EOF > $file_path ... EOF";
    open(my $fh, ">", encode($encoded_code, $file_path)) or die "Error: $!";

    say $fh '" ' . $description;
    say $fh "\" This is custom settins, for more details $readme_path";
    say $fh "set runtimepath+=$rc_path";
    say $fh "let g:VIM_DOTFILES_ROOT_DIR='$this_script_directory_path'";
    say $fh "runtime! init.vim";
}


sub get_today_for_file_name_suffix {
    my ($sec, $min, $hour, $mday, $mon, $year) = localtime;

    $year = sprintf("%04d", $year + 1900);
    $mon = sprintf("%02d", $mon + 1);
    $mday = sprintf("%02d", $mday);
    $hour = sprintf("%02d", $hour);
    $min = sprintf("%02d", $min);
    $sec = sprintf("%02d", $sec);

    return join("_", ($year, $mon, $mday, $hour, $min, $sec));
}


0;
