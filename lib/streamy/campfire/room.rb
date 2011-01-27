require 'rest_client'
require 'nokogiri'
require 'active_support/core_ext/object/returning'
require 'active_support/core_ext/hash/keys'

module Campfire
  class Room
    attr_accessor :service, :id
    # path = '/room/#{id}/transcript.xml'
    def initialize(id, service)
      @id = id
      @service = service
    end
    def uri
      @service.uri.merge "/room/#{id}" 
    end
    
    def resource
      RestClient.get(uri.to_s).body
    end
  end
end