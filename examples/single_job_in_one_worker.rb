require_relative "../lib/rails_permanent_job"

class Job
  def self.call(logger)
    logger.info "Doing Job"
  end
end

class AfterJob
  def self.call(logger)
    logger.info "Waiting for 1 second"

    sleep 1
  end
end

RailsPermanentJob.jobs = [Job]
RailsPermanentJob.after_job = AfterJob
RailsPermanentJob.run(worker_count: 1)
