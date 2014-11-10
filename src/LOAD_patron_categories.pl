## LOAD_patron_categories.pl
use Catmandu::Importer::CSV;
use Data::Dumper;
use Catmandu::Store::DBI;

my $store = Catmandu::Store::DBI->new(data_source => 'DBI:mysql:database=koha_name;host=0.0.0.0:3306',
                                      username => 'admin',
                                      password => 'secret',
                                      );
my $bag = $store->bag('categories');

my $importer = Catmandu::Importer::CSV->new(file => "/data/patron_categories.csv");
# TODO: find a way to extract this from importer
# my @columns = ['categorycode','description'];
print Dumper($importer);
# my $successCount = 0;
my $importCount = $importer->each(sub {
                my $xxx = shift;
                print Dumper($xxx);
                my $id = $bag->add($xxx);
                printf "obj1 stored as %s\n" , $id->{_id};
        });
# $store->bag->each(sub {
#   my $item = shift;
#   print Dumper($item);
#   });
# print "Log: $bag->log";
# print "Extracted: $importCount items\n";
# print "Loaded: $successCount items\n";

# if ($importCount == $successCount) {
#     print "SUCCESS!\n";
#     exit 0;
# }
# else {
#     print "FAIL!!!\n";
#     exit 1;
# }
