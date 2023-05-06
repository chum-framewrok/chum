module Squirm
  module Fetchers
    class ProxiesAPI < Base
      Log = ::Log.for(self)

      def initialize(@spider : Spider, @api_key : String, @render : Bool = false)
      end

      def fetch(request : Request) : Response
        if request.filter(@spider)
          url = "http://api.proxiesapi.com/?auth_key=#{@api_key}&url=#{request.url}&render=#{@render}"
          request = Request.new(:get, url)

          Response.new(request.execute.http_client_res, request)
        else
          Log.error { "Failed to validate the request to #{request.url} through the filter for spider #{@spider.id}." }
          raise Exception.new
        end
      end
    end
  end
end
