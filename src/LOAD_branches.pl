## LOAD_branches.pl
use Catmandu::Importer::CSV;
use Data::Dumper;
use HTTP::Request;
use HTTP::Response;
use LWP::UserAgent;
use JSON;

my $uri = "http://localhost:8080/cgi-bin/koha/rest.pl/branch";
my $headers = HTTP::Headers->new( Content_Type => 'application/json' );
my $request = HTTP::Request->new( "POST", $uri, $headers );
my $ua = LWP::UserAgent->new;
my $response;

my $file = $ARGV[0];
if (! $file) {
    print "\nUsage: $0 path/to/csv\n";
    exit 1;
}
my $importer = Catmandu::Importer::CSV->new(file => $file);
my $successCount = 0;

my $importCount = $importer->each(sub {
                my $post_data = to_json(shift);
                $request->content($post_data);
                $response = $ua->request($request);
                if ($response->is_success) {
     				my $message = $response->decoded_content;
                    print "HTTP response code/Location:\t", $response->code, "\t", $response->header('Location'), "\n";
                    $successCount++;       
				}
				else {
    				print "HTTP response code/message:\t", $response->code, "\t", $response->message, "\n";
				}
});

print "Extracted: $importCount items\n";
print "Loaded: $successCount items\n";

if ($importCount == $successCount) {
    print "SUCCESS!\n";
    exit 0;
}
else {
    print "FAIL!!!\n";
    exit 1;
}
