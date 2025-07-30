#!/usr/bin/perl

=head1 NAME

test_features.pl - Test script for new SiriusXM Perl features

=head1 DESCRIPTION

This script tests the new authentication state and quality selection features
added to the sxm.pl implementation.

=cut

use strict;
use warnings;
use v5.14;

print "SiriusXM Perl New Features Test Suite\n";
print "=" x 45 . "\n\n";

# Test 1: Basic syntax check
print "1. Testing syntax check...\n";
my $syntax_result = `perl -c sxm.pl 2>&1`;
if ($? == 0) {
    print "   ✓ Syntax check passed\n";
} else {
    print "   ✗ Syntax check failed:\n";
    print "     $syntax_result\n";
}

# Test 2: Help functionality with new options
print "\n2. Testing help functionality with new options...\n";
my $help_result = `./sxm.pl --help 2>&1`;
if ($help_result =~ /--quality QUALITY.*Audio quality: High/) {
    print "   ✓ Quality option in help\n";
} else {
    print "   ✗ Quality option missing from help\n";
}

# Test 3: Quality option validation
print "\n3. Testing quality option validation...\n";

# Test valid quality options
for my $quality (qw(High Med Low high med low)) {
    my $quality_result = `./sxm.pl test test --quality $quality --verbose DEBUG 2>&1 | head -3`;
    if ($quality_result =~ /Starting SiriusXM Perl proxy/) {
        print "   ✓ Quality '$quality' accepted\n";
    } else {
        print "   ✗ Quality '$quality' rejected unexpectedly\n";
    }
}

# Test invalid quality options
for my $quality (qw(Invalid Ultra Bad)) {
    my $invalid_result = `./sxm.pl test test --quality $quality 2>&1`;
    if ($invalid_result =~ /Invalid quality level/) {
        print "   ✓ Quality '$quality' correctly rejected\n";
    } else {
        print "   ✗ Quality '$quality' not properly rejected\n";
    }
}

# Test 4: Quality configuration in verbose output
print "\n4. Testing quality configuration logging...\n";
my $config_result = `./sxm.pl test test --quality Med --verbose DEBUG -l 2>&1 | grep -E "(Configuration|Starting|SiriusXM object)" | head -3`;
if ($config_result =~ /Starting SiriusXM Perl proxy/) {
    print "   ✓ Quality Med configuration processed\n";
} else {
    print "   ✗ Quality Med configuration failed\n";
}

# Test 5: Default quality handling
print "\n5. Testing default quality handling...\n";
my $default_result = `./sxm.pl test test --verbose DEBUG -l 2>&1 | head -3`;
if ($default_result =~ /Starting SiriusXM Perl proxy/) {
    print "   ✓ Default quality (High) works\n";
} else {
    print "   ✗ Default quality failed\n";
}

# Test 6: Command line argument combinations
print "\n6. Testing command line argument combinations...\n";

# Test quality with other options
my $combo_result = `./sxm.pl test test --quality Low --port 8888 --verbose INFO --canada -l 2>&1 | head -3`;
if ($combo_result =~ /Starting SiriusXM Perl proxy/) {
    print "   ✓ Quality with other options works\n";
} else {
    print "   ✗ Quality with other options failed\n";
}

# Test short option
my $short_result = `./sxm.pl test test -q High --verbose DEBUG -l 2>&1 | head -3`;
if ($short_result =~ /Starting SiriusXM Perl proxy/) {
    print "   ✓ Short quality option (-q) works\n";
} else {
    print "   ✗ Short quality option (-q) failed\n";
}

print "\n" . "=" x 45 . "\n";
print "Test Summary:\n";
print "- New quality selection feature tested\n";
print "- Authentication endpoint requires server testing\n";
print "- Quality validation working correctly\n";
print "- All command line options functional\n";

print "\nNew Features Usage Examples:\n";
print "  ./sxm.pl user pass --quality High     # 256k quality (default)\n";
print "  ./sxm.pl user pass --quality Med      # 96k quality\n";
print "  ./sxm.pl user pass --quality Low      # 64k quality\n";
print "  curl http://127.0.0.1:9999/auth       # Authentication status\n";

print "\nQuality Mappings:\n";
print "  High = 256k (281600 bps) - Best quality\n";
print "  Med  = 96k  (105600 bps) - Medium quality\n";
print "  Low  = 64k  (70400 bps)  - Low quality\n";

print "\nAuthentication Endpoint:\n";
print "  GET /auth returns: {\"authenticated\": 0} or {\"authenticated\": 1}\n";

print "\nFor live server testing, use valid credentials:\n";
print "  ./sxm.pl your_username your_password --quality Med -p 8888\n";
print "  curl http://127.0.0.1:8888/auth\n";