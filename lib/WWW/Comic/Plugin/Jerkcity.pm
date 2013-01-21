package WWW::Comic::Plugin::Jerkcity;

use warnings;
use strict;

use vars qw($VERSION @ISA %COMICS);
our $VERSION	= '0.080085';
@ISA		= qw(WWW::Comic::Plugin);
%COMICS		= ( jerkcity => 'Jerkcity - I SAW A GHOST');

sub new {
	my $class = shift;
	my $self = { uri => 'http://www.jerkcity.com' };
	bless $self, $class;
	return $self
}

sub strip_url {
	my ( $self, %args ) = @_;

	$self->{ua}	||= $self->_new_agent;

	$self->{cur}	or do { my $r = $self->{ua}->get( "$self->{uri}/high.txt" );
				chomp ( $self->{cur} = ( $r->is_success ? $r->content : 5121 ) ) };

	return		( ( exists $args{id} and $args{id} =~ /\d+$/ and $args{id} <= $self->{cur} )
				? "$self->{uri}/jerkcity$args{id}.gif"
				: "$self->{uri}/today.gif"
			)
}

=head1 NAME

WWW::Comic::Plugin::Jerkcity - WWW::Comic plugin to fetch Jerkcity

=head1 SYNOPSIS

See L<WWW::Comic> for full details.

	use strict;
	use warnings;

	use WWW::Comic;

	my $huglaghalglah = new WWW::Comic;

	my $latest = $huglaghalglah->get_strip( comic => 'jerkcity' );

	my $specific = $huglaghalglah->get_strip( comic => 'jerkcity', id => 23 );

=head1 DESCRIPTION

A plugin for L<WWW::Comic> to fetch the Jerkcity comic from http://www.jerkcity.com/

See L<WWW::Comic> and L<WWW::Comic::Plugin> for information on the WWW::Comic
interface.


=head1 FUNCTIONS

=over 4

=item new

Constructor - see L<WWW::Comic> for usage

=cut

=head1 AUTHOR

Luke Poskitt, C<< <ltp at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-www-comic-plugin-jerkcity at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=WWW-Comic-Plugin-Jerkcity>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc WWW::Comic::Plugin::Jerkcity


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=WWW-Comic-Plugin-Jerkcity>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/WWW-Comic-Plugin-Jerkcity>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/WWW-Comic-Plugin-Jerkcity>

=item * Search CPAN

L<http://search.cpan.org/dist/WWW-Comic-Plugin-Jerkcity/>

=back

=head1 ACKNOWLEDGEMENTS

=head1 LICENSE AND COPYRIGHT

Copyright 2013 Luke Poskitt.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut



1;