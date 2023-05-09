require_relative "../lib/rails_permanent_job"

class HardThingToDo
  def self.call(logger:, **_options)
    hard_work_time = rand

    logger.info "working hard for #{hard_work_time} second"

    sleep hard_work_time
  end
end

RailsPermanentJob.jobs = [HardThingToDo]
RailsPermanentJob.run(workers: 4)
