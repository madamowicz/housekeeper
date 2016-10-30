#!/usr/bin/perl
#
#
#
use strict;
use warnings;
use File::Find;
no warnings 'File::Find';
use Digest::MD5::File qw(file_md5_hex);


my $md5 = Digest::MD5->new;
my $path="/home/marcin";
my %options = ( wanted => \&display,
		follow_skip => '2');

my @directories = (
    "$path/backup",
    "$path/bin",
    "$path/Desktop",
    "$path/Documents",
    "$path/Downloads",
    "$path/Music",
    "$path/Pictures",
    "$path/Public",
    "$path/scripting",
    "$path/Templates",
    "$path/tmp",
    "$path/Videos",
    "$path/VirtualBox VMs",
    "$path/yEd");

find( \%options, @directories );

sub display {
my $sum;
my $type;
   if ( ! -d $_ ) {
      return if ! -e $_;
      $md5->addpath("$File::Find::name");
      $sum = $md5->hexdigest;
      $type='link' if -l $_;
      $type ||= 'reqular';
      print "$sum\ttype: $type\t$File::Find::name\n";
   }
}


