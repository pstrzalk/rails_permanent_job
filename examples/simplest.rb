require_relative "../lib/rails_permanent_job"

class Beep
  def self.call(logger:, **_options)
    logger.info "beep"
  end
end

RailsPermanentJob.jobs = [Beep]
RailsPermanentJob.run(workers: 1)
