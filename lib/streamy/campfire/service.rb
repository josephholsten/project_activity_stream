require 'rest_client'
require 'nokogiri'
require 'active_support/core_ext/object/returning'
require 'streamy/campfire/room'

module Campfire
  class Service
    attr_accessor :token, :subdomain, :secure
    # takes a hash for :token, :subdomain, and :secure
    # :token should have the API token for your account
    # :subdomain should be the subdomain for the campfire service
    # :secure should be set to true if the campfire service uses https
    def initialize(token, subdomain, secure = false)
      @token = token
      @subdomain = subdomain
      @secure = secure
    end
    def secure?
      @secure
    end
    def uri
      scheme = @secure ? 'https' : 'http'
      URI::Generic.build :scheme => scheme,
        :host => @subdomain + '.campfirenow.com',
        :userinfo => @token
    end
    def resource
      RestClient.get(uri.to_s).body
    end
    def rooms
      Rooms.new(self)
    end
  end
  
  class Rooms
    attr_accessor :service
    def initialize(service)
      @service = service
    end
    def uri
      @service.uri.merge '/rooms'
    end
    def resource
      RestClient.get(uri.to_s).body
    end
    def doc
      Nokogiri::XML(resource)
    end
    def room_ids
      doc.search('/rooms/room/id').map{|id| id.text.to_i}
    end
  end
end