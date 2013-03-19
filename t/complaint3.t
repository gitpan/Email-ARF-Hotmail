#!/usr/bin/perl -w

use strict;
use Test::More tests => 5;

use Email::ARF::Hotmail;

# FH because we're being backcompat to pre-lexical
sub readfile {
	my $fn = shift;
	open FH, "$fn" or die $!;
	local $/;
	my $text = <FH>;
	close FH;
	return $text;
}

my $message = readfile('t/corpus/hotmail2.msg');

my $report = Email::ARF::Hotmail->create_report($message);

my $des = $report->description;
chomp $des;

is($des, "An email abuse report from hotmail\r", "description is right");
is($report->field("Source-IP"), "3.4.5.6", "source IP is right");
is($report->field("Feedback-Type"), "abuse", "feedback type is right");
is($report->field("User-Agent"), "Email::ARF::Hotmail-conversion", "user agent is right");
is($report->field("Version"), "0.1", "version is right");
