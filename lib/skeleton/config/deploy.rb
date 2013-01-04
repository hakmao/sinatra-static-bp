require 's3-static-site'
require 'capistrano/ext/multistage'

set :default_stage, 'development'

set :s3, YAML::load( File.open( File.expand_path( '../s3.yml', __FILE__ ) ) )

before 'deploy' do
  run_locally "rm -rf public/*"
  run_locally "export RACK_ENV=production && bundle exec ruby app.rb"
  run_locally "export RACK_ENV=production && bundle exec rake assetpack:build"
end