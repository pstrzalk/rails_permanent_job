require_relative "../lib/rails_permanent_job"

class FirstJob
  def self.call(**options)
    logger = options[:logger]

    logger.info "Doing the first job"
  end
end

class SecondJob
  def self.call(**options)
    logger = options[:logger]

    logger.info "Doing the second job"
  end
end

class AfterJob
  def self.call(**options)
    logger = options[:logger]

    logger.info "Taking a 3s break"

    sleep 3
  end
end

RailsPermanentJob.jobs = [FirstJob, SecondJob]
RailsPermanentJob.after_job = AfterJob
RailsPermanentJob.run(worker_count: 1)
