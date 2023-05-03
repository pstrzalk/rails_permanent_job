# frozen_string_literal: true

RSpec.describe RailsPermanentJob do
  it "has a version number" do
    expect(RailsPermanentJob::VERSION).not_to be nil
  end

  it ".jobs=" do
    RailsPermanentJob.jobs = :foo

    expect(RailsPermanentJob::Worker::Configuration.jobs).to eq(:foo)

    RailsPermanentJob.jobs = RailsPermanentJob::Worker::Configuration::DEFAULT_JOBS
  end

  it ".after_job=" do
    RailsPermanentJob.after_job = :foo

    expect(RailsPermanentJob::Worker::Configuration.after_job).to eq(:foo)

    RailsPermanentJob.after_job = RailsPermanentJob::Worker::Configuration::DEFAULT_AFTER_JOB
  end

  it ".run" do
    allow(RailsPermanentJob::Run).to receive(:call)

    RailsPermanentJob.run(foo: :bar)

    expect(RailsPermanentJob::Run).to have_received(:call).with(foo: :bar)
  end
end
