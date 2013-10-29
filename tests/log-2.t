use strict;
use Bio::KBase::Log;
use Test::More;

# we are going to use the mlog_file config file setting in test1
unlink "test1.foo.bar.log" if -e "test1.foo.bar.log";
unlink "test2.foo.bar.log" if -e "test2.foo.bar.log";
unlink "test3.foo.bar.log" if -e "test3.foo.bar.log";
$ENV{"MLOG_CONFIG_FILE"} = "./tests/log.cfg";

# test1
my $m = Bio::KBase::Log->new("test1");
ok($m->get_log_level() == 1, "loglevel is 1");

$m->log_message(2, "my test message 1 at log level 2 with no ocnstraints");
$m->log_message(3, "my test message 1 at log level 3 with no constraints");
$m->log_message(4, "my test message 2 at log level 4 with no constraints");
$m->log_message(5, "my test message 3 at log level 5 with no constraints");
ok(! -e "test1.foo.bar.log", "test1.foo.bar.log does not exist");

$m->log_message(1, "my test message 4 at log level 1 with no constraints");
ok(-e "test1.foo.bar.log", "test1.foo.bar.log exists"); 
unlink "test1.foo.bar.log" if -e "test1.foo.bar.log";

# test2
my %log_constraints = ('job' => '3', 'stage' => '350');
my $m = Bio::KBase::Log->new("test2", \%log_constraints);
ok($m->get_log_level() == 2, "loglevel is 2");

$m->log_message(3, "my test message 1 at log level 3 with constraints job=3 and stage=350");
$m->log_message(4, "my test message 2 at log level 4 with constraints job=3 and stage=350");
$m->log_message(5, "my test message 3 at log level 5 with constraints job=3 and stage=350");
ok(!-e "test2.foo.bar.log", "test2.foo.bar.log does not exist");
ok(!-e "test1.foo.bar.log", "test1.foo.bar.log does not exist");

$m->log_message(2, "my test message 4 at log level 2 with constraints job=3 and stage=350");
ok(-e "test2.foo.bar.log", "test2.foo.bar.log exists");
unlink "test2.foo.bar.log" if -e "test2.foo.bar.log";

# test3
my $m = Bio::KBase::Log->new("test3", \%log_constraints);
ok($m->get_log_level() == 5, "loglevel is 5");

$m->log_message(3, "my test message 7 at log level 3 with constraints job=3 and stage=350");
$m->log_message(4, "my test message 8 at log level 4 with constraints job=3 and stage=350");
ok(-e "test3.foo.bar.log", "test3.foo.bar.log exists");
unlink "test3.foo.bar.log" if -e "test3.foo.bar.log";

$m->log_message(5, "my test message 9 at log level 5 with constraints job=3 and stage=350");
ok(-e "test3.foo.bar.log", "test3.foo.bar.log exists");
unlink "test3.foo.bar.log" if -e "test3.foo.bar.log";

#log_message('emergency', "this program is finished");


done_testing();
