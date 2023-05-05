# frozen_string_literal: true

require "serverengine"

module RailsPermanentJob
  Error = Class.new(StandardError)

  def self.jobs=(jobs)
    Worker::Configuration.jobs = jobs
  end

  def self.after_job=(after_job)
    Worker::Configuration.after_job = after_job
  end

  def self.run(**params)
    Run.call(params)
  end
end

require_relative "rails_permanent_job/version"
require_relative "rails_permanent_job/worker"
require_relative "rails_permanent_job/run"
