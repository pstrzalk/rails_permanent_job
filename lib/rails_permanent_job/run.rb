module RailsPermanentJob
  class Run
    DEFAULT_WORKER_COUNT = 1
    DEFAULT_PID_PATH = "tmp/rails_permanent_job.pid".freeze
    DEFAULT_LOG_FILE_NAME = "rails_permanent_job.log".freeze
    DEFAULT_LOG_LEVEL = "debug".freeze
    DEFAULT_LOG_ROTATE_AGE = 5
    DEFAULT_LOG_ROTATE_SIZE = 1_048_576 # 1024 * 1024

    DEFAULT_PARAMS = {
      daemonize: false,
      log_file_name: DEFAULT_LOG_FILE_NAME,
      log_level: DEFAULT_LOG_LEVEL,
      log_rotate_age: DEFAULT_LOG_ROTATE_AGE,
      log_rotate_size: DEFAULT_LOG_ROTATE_SIZE,
      pid_path: DEFAULT_PID_PATH,
      supervisor: true,
      workers: DEFAULT_WORKER_COUNT,
      worker_type: "process"
    }.freeze

    def self.call(params = {})
      ServerEngine
        .create(nil, Worker, DEFAULT_PARAMS.merge(params))
        .run
    end
  end
end
