use strict;
use warnings;

use Test::More;
use Test::Differences;
use Test::Exception;

use autobox::Core;

use lib "lib";
use autobox::Transform;

use lib "t/lib";
use Literature;

my $literature = Literature::literature();
my $authors    = $literature->{authors};

subtest filter => sub {
    note "ArrayRef call, list context result, subref predicate";
    eq_or_diff(
        [ map { $_->name } $authors->filter(sub { $_->is_prolific }) ],
        [
            "James A. Corey",
        ],
        "filter simple method call works",
    );

    note "list call, list context result";
    my @authors = @$authors;
    my $prolific_authors = @authors->filter(sub { $_->is_prolific });
    eq_or_diff(
        [ map { $_->name } @$prolific_authors ],
        [
            "James A. Corey",
        ],
        "filter simple method call works",
    );
};

done_testing();