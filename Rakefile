# frozen_string_literal: true

require "bundler/gem_tasks"
require_relative "lib/rails_permanent_job"

desc "Example permanent job"
task :example_permanent_job do
  job = ->(logger) { logger.info "I am doing it" }
  after_job = ->(logger) { sleep 1 }

  RailsPermanentJob.jobs = [job]
  RailsPermanentJob.after_job = after_job
  RailsPermanentJob.run(worker_count: 1)
end
