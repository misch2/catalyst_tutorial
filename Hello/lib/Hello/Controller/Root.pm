package Hello::Controller::Root;
use Moose;
use namespace::autoclean;
use utf8;

BEGIN { extends 'Catalyst::Controller' }
BEGIN { extends 'Catalyst::Controller::REST' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(namespace => '');
#__PACKAGE__->config(default => 'text/xml');
#__PACKAGE__->config(default => 'application/json');
#__PACKAGE__->config(encoding => 'UTF-8');

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    # Hello World
    $c->response->body( $c->welcome_message );
}

#sub hello :Global {
#    my ($self, $c) = @_;
#    $c->response->body('Ahoj, test češtiny');  # nepouzije RenderView, vrati primo toto
#}
sub hello :Global {
    my ( $self, $c ) = @_;
    $c->stash(template => 'hello.tt');
}


sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}




sub thing : Local : ActionClass('REST') { }

# Answer GET requests to "thing"
sub thing_GET {
   my ( $self, $c ) = @_;

   # Return a 200 OK, with the data in entity
   # serialized in the body
   $self->status_ok(
        $c,
        entity => {
            some => 'data s češtinou',
            foo  => 'is real bar-y',
            xyzzy => ['a', 'b', 'c' => {d => 'e'}],
        },
   );
}

# Answer PUT requests to "thing"
sub thing_PUT {
    my ( $self, $c ) = @_;

    my $radiohead = $c->req->data->{radiohead};

    $self->status_created(
        $c,
        location => $c->req->uri,
        entity => {
            radiohead => $radiohead,
            vsechno_ok => 1,
        }
    );
}

sub end : ActionClass('RenderView') {}


__PACKAGE__->meta->make_immutable;

1;
