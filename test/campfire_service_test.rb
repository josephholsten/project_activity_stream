#!/usr/bin/env ruby
$:.unshift File.expand_path('..',__FILE__)
require 'test_helper'
require 'test/unit'
require 'streamy/campfire'

class CampfireServiceTest < Test::Unit::TestCase
  def setup
    @service = Campfire::Service.new 'foo', 'bar', true
  end
  def test_should_get_token
    assert_equal 'foo', @service.token
  end
  def test_should_get_subdomain
    assert_equal 'bar', @service.subdomain
  end
  def test_should_get_secure
    assert_equal true, @service.secure
  end
  # def test_should_find_room_ids
  #   assert_equal '', @service.room_ids
  # end

  def test_should_build_uri
    assert_equal 'https://foo@bar.campfirenow.com', @service.uri.to_s
  end
  # def test_should_get_resource
  #   assert_equal '', @service.resource
  # end
end

# class CampfireServiceLiveTest < Test::Unit::TestCase
#   def setup
#     @token = '6538bc6e0104c939699458c1e30a552d1cb1a779'
#     @service = Campfire::Service.new @token,
#       :subdomain => 'josephholsten'#, :secure => true
#   end
#   def test_should_get_resource
#     resp = @service.resource
#     assert_equal expected, resp.body
#   end
#   def test_should_get_rooms_doc
#     rooms_uri = @service.uri.merge '/rooms'
#     resp = RestClient.get(rooms_uri.to_s).body
#     doc = Nokogiri::XML(resp)
#     assert_equal '', resp
#   end
# end

class CampfireServiceImplicitSecurityTest < Test::Unit::TestCase
  def setup
    @service = Campfire::Service.new 'foo', 'bar'
  end
  def test_should_get_token
    assert_equal 'foo', @service.token
  end
  def test_should_get_subdomain
    assert_equal 'bar', @service.subdomain
  end
  def test_should_get_secure
    assert_equal false, @service.secure
  end
end