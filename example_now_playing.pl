#!/usr/bin/perl

=head1 NAME

example_now_playing.pl - Example usage of now-playing functionality

=head1 DESCRIPTION

This script demonstrates how to use the new now-playing functionality
in the SiriusXM Perl implementation.

=cut

use strict;
use warnings;
use v5.14;

print "SiriusXM Now-Playing Feature Example\n";
print "=" x 40 . "\n\n";

print "This example demonstrates the new now-playing functionality.\n";
print "The implementation adds support for fetching current track information.\n\n";

print "Key Features:\n";
print "- Fetches now-playing info from SiriusXM API\n";
print "- Supports single channel or multiple channels\n";
print "- Handles channel names, IDs, and Sirius numbers\n";
print "- Returns structured JSON data\n";
print "- Includes comprehensive error handling\n\n";

print "API Usage Examples:\n";
print "1. Single channel by name:\n";
print "   GET /now-playing/siriushits1\n\n";

print "2. Single channel by number:\n";
print "   GET /now-playing/2\n\n";

print "3. Multiple channels:\n";
print "   GET /now-playing/siriushits1,thepulse,coffeehouse\n\n";

print "4. Mixed channel identifiers:\n";
print "   GET /now-playing/siriushits1,2,thepulse\n\n";

print "Server Setup:\n";
print "1. Start the server with your credentials:\n";
print "   ./sxm.pl your_username your_password -p 8888\n\n";

print "2. Make HTTP requests to the now-playing endpoint:\n";
print "   curl http://127.0.0.1:8888/now-playing/siriushits1\n";
print "   curl http://127.0.0.1:8888/now-playing/siriushits1,thepulse\n\n";

print "Expected Response Format:\n";
print "The API returns JSON with current track information:\n";
print "{\n";
print "  \"channelData\": {\n";
print "    \"channelId\": {\n";
print "      \"track\": \"Song Title\",\n";
print "      \"artist\": \"Artist Name\",\n";
print "      \"album\": \"Album Name\",\n";
print "      \"duration\": 180000,\n";
print "      \"startTime\": \"2025-08-01T02:30:00Z\",\n";
print "      // ... additional track metadata\n";
print "    }\n";
print "  }\n";
print "}\n\n";

print "Error Handling:\n";
print "- Invalid channel IDs return HTTP 400 Bad Request\n";
print "- Authentication failures are handled gracefully\n";
print "- Network errors are logged and reported\n";
print "- Input validation prevents malformed requests\n\n";

print "Implementation Details:\n";
print "- Uses SiriusXM REST API endpoint: /rest/v2/experience/now-playing/ids\n";
print "- Supports comma-separated channel ID parameter\n";
print "- Maintains session authentication automatically\n";
print "- Follows existing code patterns and logging\n";
print "- Handles URL encoding/decoding properly\n\n";

print "Integration with Existing Features:\n";
print "- Works alongside existing /channel/ endpoint\n";
print "- Uses same authentication system\n";
print "- Follows same HTTP response patterns\n";
print "- Compatible with all existing functionality\n\n";

print "For complete documentation, see PERL_IMPLEMENTATION.md\n";