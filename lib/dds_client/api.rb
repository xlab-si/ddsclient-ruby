require "excon"
require "json"

require "dds_client/exceptions"

module DdsClient
  class Api
    def self.create_from_env
      puts(ENV.fetch("DDS_VERIFY_SSL", "true"))
      new(
        ENV.fetch("DDS_URL"),
        ENV.fetch("DDS_USERNAME"),
        ENV.fetch("DDS_PASSWORD"),
        ENV.fetch("DDS_VERIFY_SSL", "true") != "false"
      )
    rescue KeyError => e
      raise DdsClient::ConfigError, "Set environment vars (#{e})"
    end

    def initialize(url, username, password, verify_ssl)
      url = url.chomp("/")
      token = authenticate(url, username, password, verify_ssl)

      params = {
        headers: {
          "Content-Type" => "application/json",
          "Authorization" => "Token #{token}"
        },
        ssl_verify_peer: verify_ssl
      }
      @connection = Excon.new(url, params)
    end

    def authenticate(url, username, password, verify_ssl)
      r = Excon.post(
        "#{url}/auth/get-token",
        headers: { "Content-Type" => "application/json" },
        body: { "username" => username, "password" => password }.to_json,
        ssl_verify_peer: verify_ssl
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
