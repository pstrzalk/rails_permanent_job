# frozen_string_literal: true

module RailsPermanentJob
  RSpec.describe Run do
    describe ".call" do
      it 'runs a server engine daemon with default options' do
        server_engine_daemon = instance_double(ServerEngine::Daemon)
        allow(ServerEngine).to receive(:create).with(
          nil,
          Worker,
          {
            daemonize: false,
            log_file_name: "rails_permanent_job.log",
            log_level: "debug",
            log_rotate_age: 5,
            log_rotate_size: 1_048_576,
            pid_path: "tmp/rails_permanent_job.pid",
            supervisor: true,
            workers: 1,
            worker_type: "process"
          }
        ).and_return(server_engine_daemon)
        expect(server_engine_daemon).to receive(:run).with(no_args)

        Run.call
      end

      it 'runs a server engine daemon with overridden options' do
        server_engine_daemon = instance_double(ServerEngine::Daemon)
        allow(ServerEngine).to receive(:create).with(
          nil,
          Worker,
          {
            daemonize: true,
            log_file_name: "changed_rails_permanent_job.log",
            log_level: "info",
            log_rotate_age: 10,
            log_rotate_size: 1024,
            pid_path: "tmp/changed_rails_permanent_job.pid",
            supervisor: false,
            workers: 3,
            worker_type: "spawn"
          }
        ).and_return(server_engine_daemon)
        expect(server_engine_daemon).to receive(:run).with(no_args)

        Run.call(
          daemonize: true,
          log_file_name: "changed_rails_permanent_job.log",
          log_level: "info",
          log_rotate_age: 10,
          log_rotate_size: 1024,
          pid_path: "tmp/changed_rails_permanent_job.pid",
          supervisor: false,
          workers: 3,
          worker_type: "spawn"
        )
      end
    end
  end
end
