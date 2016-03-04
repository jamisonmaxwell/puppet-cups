# Class: cups::default_queue
#
# Sets the default destination for all print jobs.
#
# Every node can only have one default CUPS destination.
# Therefore we implement it as class to generate a Puppet catalog singleton.
#
# String :: queue
#
class cups::default_queue (
  $queue
) {
  assert_private("The class 'cups::default_queue' is private. Please use\n\n  class { '::cups':\n    default_queue => '${queue}',\n  }\n\ninstead.")

  validate_string($queue)

  exec { 'lpadmin-d':
    command => "lpadmin -E -d ${queue}",
    unless  => "lpstat -d | grep -w ${queue}",
    path    => ['/usr/local/sbin/', '/usr/local/bin/', '/usr/sbin/', '/usr/bin/', '/sbin/', '/bin/'],
    require => Cups_queue[$queue]
  }
}