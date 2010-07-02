require 'rubygems'
require 'rake'
require 'rake/testtask'
require 'rcov/rcovtask'
require 'rake/rdoctask'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |g|
    g.name = 'artforge-rtranslate'
    g.summary = %(Google translate ruby client api)
    g.description = %(A simple, unofficial, ruby client API for using Google Translate.)
    g.email = "adam@artforge.com"
    g.homepage = "http://github.com/Artforge/rtranslate"
    g.authors = ["shisen","opengotham","Artforge"]
    g.add_dependency 'json', '>= 1.1.3'
    g.add_development_dependency 'shoulda'
    g.add_development_dependency 'mocha'
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts 'Jeweler (or a dependency) not available. Install it with: gem install jeweler'
end