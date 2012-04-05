use strict;
use warnings;
use Test::More;
use FindBin;
use lib "$FindBin::Bin/../lib";

use Plack::Test;
use Plack::Builder;
use HTTP::Request::Common;
use Plack::Middleware::Magpie;

my $handler = builder {
    enable "Magpie", context => {}, pipeline => [
		'Magpie::Pipeline::PathMadness' => {
			traits => ['URITemplate'],
			uri_template => '/shop/{store_id}/item/{item_id}',
		}
    ];
};

use Data::Printer;
test_psgi
    app    => $handler,
    client => sub {
        my $cb = shift;
        {
            my $res = $cb->(GET "http://localhost/shop/aaa/item/1234567");
            like $res->content, qr|_pathmadness_aaa_1234567|;
        }
    };

done_testing();