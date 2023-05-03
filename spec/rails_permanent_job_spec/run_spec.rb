# frozen_string_literal: true

module RailsPermanentJob
  RSpec.describe Run do
    it ".call" do
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
          worker_count: 1,
          worker_type: "process"
        }
      ).and_return(server_engine_daemon)
      expect(server_engine_daemon).to receive(:run).with(no_args)

      Run.call
    end
  end
end
