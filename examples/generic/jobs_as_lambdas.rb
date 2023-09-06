require_relative "../../lib/rails_permanent_job"

timer_sound_job = ->(logger:, **_options) do
  even_second = Time.now.to_i % 2 == 0

  sound = even_second ? "tic" : "tac"

  logger.info sound
end

after_job = ->(_) { sleep 1 }

RailsPermanentJob.jobs = [timer_sound_job]
RailsPermanentJob.after_job = after_job
RailsPermanentJob.run(workers: 1)
