require 'rake'
require 'spec/spec_helper'
require 'spec/rake/spectask'

desc 'Default: run all specs.'
task :default => :spec

spec_opts_path = Rake.original_dir + '/spec/spec.opts'

desc "Run all specs in spec directory (excluding plugin specs)"
Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_opts = ['--options', "\"#{spec_opts_path}\""]
  t.spec_files = FileList['spec/**/*_spec.rb']
end
