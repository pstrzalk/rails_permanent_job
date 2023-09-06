require_relative "../../lib/rails_permanent_job"

class Job
  def self.call(logger:, config:, **options)
    logger.info "Doing Job, using config #{config.inspect}"
  end
end

class AfterJob
  def self.call(logger:, config:, **_options)
    if config[:log_level] == "debug"
      logger.info "Waiting for 1 second"
    end

    sleep 1
  end
end

RailsPermanentJob.jobs = [Job]
RailsPermanentJob.after_job = AfterJob
RailsPermanentJob.run(workers: 1, log_level: "debug")
