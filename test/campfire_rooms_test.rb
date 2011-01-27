$:.unshift File.expand_path('..',__FILE__)
require 'test_helper'
require 'test/unit'
require 'streamy/campfire'

class CampfireRoomsLiveTest < Test::Unit::TestCase
  def setup
    @service = Campfire::Service.new '6538bc6e0104c939699458c1e30a552d1cb1a779', 'josephholsten'
  end
  def test_should_get_uri
    uri = @service.rooms.uri.to_s
    # resp = RestClient.get uri
    # expected = ''
    # assert_equal expected, resp.body # @service.resource
    assert_equal 'http://6538bc6e0104c939699458c1e30a552d1cb1a779@josephholsten.campfirenow.com/rooms', uri
  end
  
  def test_should_get_doc
    doc = @service.rooms.doc
    assert_equal 'rooms', doc.root.name
  end
  def test_should_get_room_ids
    ids = @service.rooms.room_ids
    assert_equal [20356, 255613], ids
  end
end