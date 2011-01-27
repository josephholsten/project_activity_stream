#!/usr/bin/env ruby
$:.unshift File.expand_path('..',__FILE__)
require 'test_helper'
require 'test/unit'
require 'streamy/campfire'

class CampfireRoomTest < Test::Unit::TestCase
  def setup
    @service = Campfire::Service.new 'foo', 'bar', true
    @room = Campfire::Room.new(20356, @service)
  end

  def test_should_set_id
    assert_equal 20356, @room.id
  end

  def test_should_set_service
    assert_equal @service, @room.service
  end

  def test_should_get_uri
    assert_equal 'https://foo@bar.campfirenow.com/room/20356', @room.uri.to_s
  end
end

class CampfireRoomLiveTest < Test::Unit::TestCase
  def setup
    @service = Campfire::Service.new '6538bc6e0104c939699458c1e30a552d1cb1a779', 'josephholsten'
    @room = Campfire::Room.new(20356, @service)
  end
  def test_should_get_resource
    expected = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<room>\n  <created-at type=\"datetime\">2006-04-28T12:43:31Z</created-at>\n  <id type=\"integer\">20356</id>\n  <membership-limit type=\"integer\">4</membership-limit>\n  <name>Private</name>\n  <topic nil=\"true\"></topic>\n  <updated-at type=\"datetime\">2007-02-10T23:00:35Z</updated-at>\n  <open-to-guests type=\"boolean\">true</open-to-guests>\n  <full type=\"boolean\">false</full>\n  <active-token-value>cb812</active-token-value>\n  <users type=\"array\"/>\n</room>\n"
    assert_equal expected, @room.resource
end
end


<?xml version="1.0" encoding="UTF-8"?>
<room>
  <created-at type="datetime">2006-04-28T12:43:31Z</created-at>
  <id type="integer">20356</id>
  <membership-limit type="integer">4</membership-limit>
  <name>Private</name>
  <topic nil="true"></topic>
  <updated-at type="datetime">2007-02-10T23:00:35Z</updated-at>
  <open-to-guests type="boolean">true</open-to-guests>
  <full type="boolean">false</full>
  <active-token-value>cb812</active-token-value>
  <users type="array"/>
</room>
