# frozen_string_literal: true

module RailsPermanentJob
  class FooWorker
    include Worker

    def logger
      @logger ||= Logger.new($stdout)
    end
  end

  class SingleRunFooWorker
    include Worker

    def logger
      @logger ||= Logger.new($stdout)
    end

    def stop_flag_set?
      return true if @checked_at_least_once

      @checked_at_least_once = true
      false
    end
  end

  RSpec.describe Worker do
    it "initializes with configurated jobs" do
      Worker::Configuration.jobs = [:foo, :bar]
      Worker::Configuration.after_job = :zoo

      foo_worker = FooWorker.new
      expect(foo_worker.instance_variable_get(:@jobs)).to eq [:foo, :bar]
      expect(foo_worker.instance_variable_get(:@after_job)).to eq :zoo
      expect(foo_worker.instance_variable_get(:@stop_flag)).to be_instance_of(ServerEngine::BlockingFlag)

      Worker::Configuration.jobs = Worker::Configuration::DEFAULT_JOBS
      Worker::Configuration.after_job = Worker::Configuration::DEFAULT_AFTER_JOB
    end

    describe "#run" do
      it "raises error when there are no jobs" do
        foo_worker = FooWorker.new

        expect { foo_worker.run }.to raise_error(Worker::NoJobsConfigured)
      end

      it "runs all the jobs and the after job" do
        foo = 0
        job1 = ->(_) { foo += 1 }
        job2 = ->(_) { foo += 2 }
        after_job = ->(_) { foo += 10 }
        Worker::Configuration.jobs = [job1, job2]
        Worker::Configuration.after_job = after_job

        foo_worker = SingleRunFooWorker.new
        foo_worker.run

        expect(foo).to eq(13)

        Worker::Configuration.jobs = Worker::Configuration::DEFAULT_JOBS
        Worker::Configuration.after_job = Worker::Configuration::DEFAULT_AFTER_JOB
      end
    end

    describe "#stop" do
      it "sets stop flag" do
        foo_worker = SingleRunFooWorker.new

        expect(foo_worker.instance_variable_get(:@stop_flag)).not_to be_set

        foo_worker.stop

        expect(foo_worker.instance_variable_get(:@stop_flag)).to be_set
      end
    end
  end
end
