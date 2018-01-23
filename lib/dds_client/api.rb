require "excon"
require "json"

require "dds_client/exceptions"

module DdsClient
  class Api
    def self.create_from_env
      new(ENV.fetch("DDS_URL"), ENV.fetch("DDS_USERNAME"),
          ENV.fetch("DDS_PASSWORD"), ENV["DDS_CA_FILE"])
    rescue KeyError => e
      raise DdsClient::ConfigError, "Set environment vars (#{e})"
    end

    def initialize(url, username, password, ca_file)
      url = url.chomp("/")
      token = authenticate(url, username, password, ca_file)

      params = {
        headers: {
          "Content-Type" => "application/json",
          "Authorization" => "Token #{token}"
        },
        ssl_ca_file: ca_file
      }
      @connection = Excon.new(url, params)
    end

    def authenticate(url, username, password, ca_file)
      r = Excon.post(
        "#{url}/auth/get-token",
        headers: { "Content-Type" => "application/json" },
        body: { "username" => username, "password" => password }.to_json,
        ssl_ca_file: ca_file
      )
      raise DdsClient::AuthError, "Invalid credentials" if r.status != 200
      JSON.parse(r.body)["token"]
    end

    def heartbeat
      JSON.parse(@connection.get(path: "/heartbeat/").body)
    end

    def list_containers
      JSON.parse(@connection.get(path: "/containers/").body)
    end
  end
end
