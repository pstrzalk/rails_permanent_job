module RailsPermanentJob
  module Worker
    class Configuration
      DEFAULT_JOBS = [].freeze
      DEFAULT_AFTER_JOB = ->(_logger) do
        sleep 1
      end

      def self.jobs
        @jobs || DEFAULT_JOBS
      end

      def self.jobs=(jobs)
        @jobs = jobs
      end

      def self.after_job
        @after_job || DEFAULT_AFTER_JOB
      end

      def self.after_job=(after_job)
        @after_job = after_job
      end
    end
  end
end
