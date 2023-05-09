# RailsPermanentJob

RailsPermanentJob is a way to easily run a reliable process performing a set of jobs. It may be easily used to build an independent worker performing a permanent job for a Ruby on Rails application.

## Story behind the project

Every now and then there is a need to perform a constant check on application's state. It has been often implemented as a cronjob running every minute, as it's the minimal interval for such a solution.
It has always been a flawed approach. Neither performing a job every second or scheduling a future job from a previous one are acceptable or reliable solutions for such a task.
RailsPermanentJob is a project which aims to provide a reliable approach to running a long-lived process alongside a Ruby on Rails application.

As its core, there is a `serverengine` gem. As [its repository](https://github.com/treasure-data/serverengine) says:
> ServerEngine is a framework to implement robust multiprocess servers like Unicorn.

`rails_permanent_job` gem simplifies usage of `serverengine` by providing a simple and reusable pattern with additional tooling.

## Installation

```
gem 'rails_permanent_job', git: 'https://github.com/pstrzalk/rails_permanent_job'
```

## Usage

Review examples in the `/examples` folder to see how to run a permanent job. Another example may be found in the `Rakefile` file included in this project.

### Minimal use case for Ruby on Rails

- install `rails_permanent_job` gem
- add a rake task by creating a file in `PROJECT_ROOT/lib/tasks/permanent_jobs.rake`
- put the following code in the file
```ruby
class BeepBeep
  def self.call(**_options)
    puts "Beep Beep"
  end
end

namespace :permanent_jobs do
  desc "Run a permanent job"
  task foo: :environment do
    RailsPermanentJob.jobs = [BeepBeep]
    RailsPermanentJob.run(worker_count: 1)
  end
end
```
- run in CLI with `bundle exec rails permanent_jobs:foo`
- kill with `Control + C` (or a similar combination appropriate for your OS)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pstrzalk/rails_permanent_job.
