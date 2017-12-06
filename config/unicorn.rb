app_dir = "/home/ubuntu/project"
shared_dir = "#{app_dir}/shared"
working_directory app_dir

worker_processes 2
preload_app true
timeout 30

listen "/tmp/unicorn.sock", :backlog => 64

stderr_path "#{shared_dir}/unicorn.stderr.log"
stdout_path "#{shared_dir}/unicorn.stdout.log"
pid "/tmp/unicorn.pid"
