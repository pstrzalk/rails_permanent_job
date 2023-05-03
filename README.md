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

TODO: Write some usage instructions

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pstrzalk/rails_permanent_job.
