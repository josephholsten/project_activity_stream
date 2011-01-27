$:.unshift File.expand_path('..',__FILE__)
require 'test_helper'
require 'test/unit'
require 'streamy/pivotal_tracker'

class PivotalTest < Test::Unit::TestCase
  def test_true; end
  # def test_should_get_activities
  #   svc = PivotalTracker::Service.new('dc5a8bb8ea76ac8363eb80fbf5ae4c42')
  #   activities = svc.activities
  #   assert_equal '16136764', activities.at('/activities/activity/id').text
  # end
#   def test_should_convert_activity_to_AS
#     activity = <<XML
# <activity>
#   <id type="integer">15790086</id>
#   <version type="integer">2335</version>
#   <event_type>story_update</event_type>
#   <occurred_at type="datetime">2010/03/31 15:30:37 CDT</occurred_at>
#   <author>Brian Dunn</author>
#   <project_id type="integer">30500</project_id>
#   <description>Brian Dunn edited "As a mobile user I can see a map for each of my search results"</description>
#   <stories>
#     <story>
#       <id type="integer">2984819</id>
#       <url>http://www.pivotaltracker.com/services/v3/projects/30500/stories/2984819</url>
#       <current_state>unstarted</current_state>
#     </story>
#   </stories>
# </activity>
# XML
#     expected = ''
#     act = PivotalTracker::Activity.parse(activity)
#     assert_equal expected, act.to_s
#   end
  # def test_should_get_activities_for_user
  #   user = PivotalTracker::Service.new('dc5a8bb8ea76ac8363eb80fbf5ae4c42').
  #     project('30500').
  #     user("Joseph Holsten")
  #   
  #   activities = user.activities
  #   assert_equal '16136764', activities
  # end
end