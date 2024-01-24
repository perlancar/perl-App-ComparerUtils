package App::ComparerUtils;

use 5.010001;
use strict 'subs', 'vars';
use warnings;

# AUTHORITY
# DATE
# DIST
# VERSION

our %SPEC;

$SPEC{list_comparer_modules} = {
    v => 1.1,
    args => {
        detail => {
            schema => 'bool*',
            cmdline_aliases => {l=>{}},
        },
    },
};
sub list_comparer_modules {
    require Module::List::Tiny;

    my %args = @_;

    my $mods = Module::List::Tiny::list_modules(
        "Comparer::", {list_modules=>1, recurse=>1});
    my @rows;
    for my $mod (sort keys %$mods) {
        (my $name = $mod) =~ s/^Comparer:://;
        if ($args{detail}) {
            (my $mod_pm = "$mod.pm") =~ s!::!/!g;
            require $mod_pm;
            my $meta = {};
            eval {
                $meta = &{"$mod\::meta"};
            };
            push @rows, {
                name => $name,
                summary => $meta->{summary},
            };
        } else {
            push @rows, $name;
        }
    }
    [200, "OK", \@rows];
}

1;
# ABSTRACT: CLIs related to Comparer

=head1 SYNOPSIS

=head1 DESCRIPTION

This distribution contains the following CLIs related to L<Comparer>:

# INSERT_EXECS_LIST


=head1 SEE ALSO

L<Comparer>

=cut
