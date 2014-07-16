requires "Bencode" => "0";
requires "DDP" => "0";
requires "Mojolicious::Controller" => "0";
requires "Mojolicious::Plugin" => "0";
requires "Myriad::Schema" => "0";
requires "SQL::Translator" => "0";
requires "base" => "0";
requires "version" => "0";

on 'test' => sub {
  requires "File::Spec" => "0";
  requires "IO::Handle" => "0";
  requires "IPC::Open3" => "0";
  requires "Mojolicious::Lite" => "0";
  requires "Test::Mojo" => "0";
  requires "Test::More" => "0";
  requires "perl" => "5.006";
  requires "strict" => "0";
  requires "warnings" => "0";
};

on 'configure' => sub {
  requires "ExtUtils::MakeMaker" => "6.30";
};

on 'develop' => sub {
  requires "Test::Pod" => "1.41";
};
