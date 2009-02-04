require 'rake'
require 'spec/rake/spectask'
require 'spec/rake/verify_rcov'

task :default => [:spec] #, :verify_rcov]

spec_opts_path = Rake.original_dir + '/spec/spec.opts'

desc "Run all specs in spec directory (excluding plugin specs)"
Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_opts = ['--options', "\"#{spec_opts_path}\""]
  t.spec_files = FileList['spec/**/*_spec.rb']
end

desc "Make sure coverage is 100%"
RCov::VerifyTask.new(:verify_rcov) do |t|
  t.threshold = 100.0
  t.index_html = 'coverage/index.html'
end
