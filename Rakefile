# frozen_string_literal: true

require "bundler/gem_tasks"
require_relative "lib/rails_permanent_job"

desc "Example permanent job"
task :example_permanent_job do
  job = ->(logger:, **_options) { logger.info "I am doing it" }
  after_job = ->(_) { sleep 3 }

  RailsPermanentJob.jobs = [job]
  RailsPermanentJob.after_job = after_job
  RailsPermanentJob.run(workers: 1)
end
