require_relative "../lib/rails_permanent_job"

#
# Recive messages from AWS SQS every 20s
#

require "aws-sdk-sqs"
require "aws-sdk-sts"

class ReceiveFromSqs
  def self.call(logger:, **_options)
    region = "eu-central-1"
    queue_name = "RailsPermanentJobQueue"
    sts_client = ::Aws::STS::Client.new(region: region)
    sqs_client = ::Aws::SQS::Client.new(region: region)
    queue_url = "https://sqs.#{region}.amazonaws.com/" \
                "#{sts_client.get_caller_identity.account}/#{queue_name}"

    logger.debug("Receiving messages from queue '#{queue_name}'...")

    response = sqs_client.receive_message(queue_url: queue_url, max_number_of_messages: 10)
    logger.debug("No messages to receive") if response.messages.count.zero?

    response.messages.each do |message|
      logger.info "Received message #{message.inspect}"
    end
  end
end

RailsPermanentJob.jobs = [ReceiveFromSqs]
RailsPermanentJob.after_job = ->(_) { sleep(20) }
RailsPermanentJob.run(workers: 1, log_level: "debug")
