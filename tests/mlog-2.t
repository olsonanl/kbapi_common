use strict;
use Bio::KBase::mlog;
use Test::More;

# we are going to use the mlog_file config file setting in test1
unlink "test1.foo.bar.log" if -e "test1.foo.bar.log";
unlink "test2.foo.bar.log" if -e "test2.foo.bar.log";
unlink "test3.foo.bar.log" if -e "test3.foo.bar.log";
$ENV{"MLOG_CONFIG_FILE"} = "./tests/mlog.cfg";

# test1
my $m = Bio::KBase::mlog->new("test1");
ok($m->get_log_level() == 1, "loglevel is 1");

$m->logit(2, "my test message 1 at log level 2 with no ocnstraints");
$m->logit(3, "my test message 1 at log level 3 with no constraints");
$m->logit(4, "my test message 2 at log level 4 with no constraints");
$m->logit(5, "my test message 3 at log level 5 with no constraints");
ok(! -e "test1.foo.bar.log", "test1.foo.bar.log does not exist");

$m->logit(1, "my test message 4 at log level 1 with no constraints");
ok(-e "test1.foo.bar.log", "test1.foo.bar.log exists"); 
unlink "test1.foo.bar.log" if -e "test1.foo.bar.log";

# test2
my %log_constraints = ('job' => '3', 'stage' => '350');
my $m = Bio::KBase::mlog->new("test2", \%log_constraints);
ok($m->get_log_level() == 2, "loglevel is 2");

$m->logit(3, "my test message 1 at log level 3 with constraints job=3 and stage=350");
$m->logit(4, "my test message 2 at log level 4 with constraints job=3 and stage=350");
$m->logit(5, "my test message 3 at log level 5 with constraints job=3 and stage=350");
ok(!-e "test2.foo.bar.log", "test2.foo.bar.log does not exist");
ok(!-e "test1.foo.bar.log", "test1.foo.bar.log does not exist");

$m->logit(2, "my test message 4 at log level 2 with constraints job=3 and stage=350");
ok(-e "test2.foo.bar.log", "test2.foo.bar.log exists");
unlink "test2.foo.bar.log" if -e "test2.foo.bar.log";

# test3
my $m = Bio::KBase::mlog->new("test3", \%log_constraints);
ok($m->get_log_level() == 5, "loglevel is 5");

$m->logit(3, "my test message 7 at log level 3 with constraints job=3 and stage=350");
$m->logit(4, "my test message 8 at log level 4 with constraints job=3 and stage=350");
ok(-e "test3.foo.bar.log", "test3.foo.bar.log exists");
unlink "test3.foo.bar.log" if -e "test3.foo.bar.log";

$m->logit(5, "my test message 9 at log level 5 with constraints job=3 and stage=350");
ok(-e "test3.foo.bar.log", "test3.foo.bar.log exists");
unlink "test3.foo.bar.log" if -e "test3.foo.bar.log";

#logit('emergency', "this program is finished");


done_testing();
