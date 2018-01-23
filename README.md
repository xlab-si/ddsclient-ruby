# DdsClient

Minimalistic client for DICE Deployment Service.


## Installation

Add this line to your application's Gemfile:

    gem 'dds_client'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dds_client


## Usage

To test the client, set proper environment variables and run `dds` command.

    $ export DDS_URL=https://10.10.10.120
    $ export DDS_USERNAME=username
    $ export DDS_PASSWORD=password
    $ export DDS_CA_FILE=dds.crt # If service is using untrusted certificate
    $ dds
    Commands:
      dds heartbeat       # check for service availability
      dds help [COMMAND]  # Describe available commands or one specific command
      dds list            # list containers that service offers

`dds` command will output json data that can be filtered using `jq` in order
to produce something a bit nicer. For example

    $ dds list | jq
    [
      {
        "id": "cce9b2c8-1af8-44fc-ab02-e3f16335293f",
        "description": "XDICE",
        "blueprint": null,
        "modified_date": "2018-01-03T10:06:59",
        "busy": false
      },
      ...
    ]


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then,
run `rake spec` to run the tests. You can also run `bin/console` for an
interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.
To release a new version, update the version number in `version.rb`, and then
run `bundle exec rake release`, which will create a git tag for the version,
push git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).


## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/[USERNAME]/dds_client.
