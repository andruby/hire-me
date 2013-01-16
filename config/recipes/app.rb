# Application start, stop and restart

set(:pid_file) { File.join(shared_path, 'thin.pid') }

namespace :app do
  desc "Start the application"
  task :start, roles: :app do
    run "cd #{current_path} && sudo bundle exec thin -p 80 -d -e production -P #{fetch(:pid_file)} start"
  end
  after "deploy:start", "app:start"

  desc "Stop the application"
  task :stop, roles: :app do
    run "cd #{current_path} && sudo bundle exec thin -t 2 -P #{fetch(:pid_file)} stop"
  end
  after "deploy:stop", "app:stop"

  desc "Start and Stop the application"
  task :restart, roles: :app do
    app.stop
    app.start
  end
  after "deploy:restart", "app:restart"

  desc "Setup the application"
  task :setup, roles: :app do
    sudo "mkdir -p /var/www"
    sudo "chown root:admin /var/www"
    sudo "chmod g+w /var/www"
  end
  before "deploy:setup", "app:setup"
end
