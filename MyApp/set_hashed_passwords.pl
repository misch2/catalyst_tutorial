#!/usr/bin/perl

use strict;
use warnings;

use MyApp::Schema;
use Data::Dumper; 

my $schema = MyApp::Schema->connect('dbi:SQLite:myapp.db');

my @users = $schema->resultset('User')->all;

foreach my $user (@users) {
    $user->password('mypass');
    $user->update;
}
