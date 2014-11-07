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

my $importer = Catmandu::Importer::CSV->new(file => "/data/branches.csv");
my $successCount = 0;

my $importCount = $importer->each(sub {
                my $post_data = shift;
                my $post_data = to_json($post_data);
                $request->content($post_data);
                $response = $ua->request($request);
                if ($response->is_success) {
     				my $message = $response->decoded_content;
                    print "HTTP response code: ", $response->code, "\n";
                    print "HTTP header: ", $response->header('Location'), "\n";;
    				print "Received reply: $message\n";
                    $successCount++;       
				}
				else {
    				print "HTTP POST error code: ", $response->code, "\n";
                    print "HTTP header: ", $response->header('Location'), "\n";;
    				print "HTTP POST error message: ", $response->message, "\n";
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
