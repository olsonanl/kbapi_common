use strict;
use Bio::KBase::Log;
use Test::More;


# test1
my $m = Bio::KBase::Log->new("test1");
ok($m->get_log_level() == 6, "default log level is 6");


# test2
my $m = Bio::KBase::Log->new("test2");
$m->set_log_file("foo");
$m->set_log_level(5);
ok($m->get_log_level() == 5, "log level is 5");


$m->log_message(3, "my test message 7 at log level 3");
$m->log_message(4, "my test message 8 at log level 4");
ok(-e "foo", "foo does exist");

unlink "foo" if -e "foo";


#logit('emergency', "this program is finished");

done_testing();

