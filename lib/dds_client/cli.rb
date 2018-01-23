require "json"
require "thor"
require "dds_client/api"

module DdsClient
  class CLI < Thor
    desc "heartbeat", "check for service availability"
    def heartbeat
      c = DdsClient::Api.create_from_env
      puts(c.heartbeat.to_json)
    end

    desc "list", "list containers that service offers"
    def list
      c = DdsClient::Api.create_from_env
      puts(c.list_containers.to_json)
    end
  end
end
