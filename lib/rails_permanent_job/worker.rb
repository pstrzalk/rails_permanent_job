require_relative "worker/configuration"

module RailsPermanentJob
  module Worker
    NoJobsConfigured = Class.new(Error)

    def initialize
      logger.info "[RailsPermanentJob] Worker Initialization"

      @after_job = Configuration.after_job
      @jobs = Configuration.jobs
      @stop_flag = ServerEngine::BlockingFlag.new
    end

    def run
      raise NoJobsConfigured unless Configuration.jobs.any?

      logger.info "[RailsPermanentJob] Worker Running in process #{Process.pid}"

      until stop_flag_set?
        @jobs.each do |job|
          job.call(logger: logger, config: config)
        end

        @after_job.call(logger: logger, config: config)
      end
    end

    def stop_flag_set?
      @stop_flag.set?
    end

    def stop
      logger.info "[RailsPermanentJob] Worker Stopping"

      @stop_flag.set!
    end
  end
end
