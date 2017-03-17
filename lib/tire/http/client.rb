module Tire

  module HTTP

    module Client

      class RestClient
        ConnectionExceptions = [::RestClient::ServerBrokeConnection, ::RestClient::RequestTimeout]

        def self.get(url, data=nil)
          perform ::RestClient::Request.new(:method => :get, :url => url, :payload => data,
            headers: Configuration.headers, user: Configuration.user, password: Configuration.password).execute
        rescue *ConnectionExceptions
          raise
        rescue ::RestClient::Exception => e
          Response.new e.http_body, e.http_code
        end

        def self.post(url, data)
          # perform ::RestClient.post(url, data)
          perform ::RestClient::Request.new(:method => :post, :url => url, :payload => data,
            headers: Configuration.headers, user: Configuration.user, password: Configuration.password).execute
        rescue *ConnectionExceptions
          raise
        rescue ::RestClient::Exception => e
          Response.new e.http_body, e.http_code
        end

        def self.put(url, data)
          # binding.pry
          # perform ::RestClient.put(url, data)
          perform ::RestClient::Request.new(:method => :put, :url => url, :payload => data,
            headers: Configuration.headers, user: Configuration.user, password: Configuration.password).execute
        rescue *ConnectionExceptions
          raise
        rescue ::RestClient::Exception => e
          Response.new e.http_body, e.http_code
        end

        def self.delete(url)
          # perform ::RestClient.delete(url)
          perform ::RestClient::Request.new(:method => :delete, :url => url,
            headers: Configuration.headers, user: Configuration.user, password: Configuration.password).execute
        rescue *ConnectionExceptions
          raise
        rescue ::RestClient::Exception => e
          Response.new e.http_body, e.http_code
        end

        def self.head(url)
          # perform ::RestClient.head(url)
          perform ::RestClient::Request.new(:method => :head, :url => url,
            headers: Configuration.headers, user: Configuration.user, password: Configuration.password).execute
        rescue *ConnectionExceptions
          raise
        rescue ::RestClient::Exception => e
          Response.new e.http_body, e.http_code
        end

        def self.__host_unreachable_exceptions
          [Errno::ECONNREFUSED, Errno::ETIMEDOUT, ::RestClient::ServerBrokeConnection, ::RestClient::RequestTimeout, SocketError]
        end

        private

        def self.perform(response)
          Response.new response.body, response.code, response.headers
        end

      end

    end

  end

end
