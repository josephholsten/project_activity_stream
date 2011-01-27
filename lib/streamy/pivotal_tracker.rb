require 'rest_client'
require 'nokogiri'
require 'active_support/core_ext/object/returning'
require 'active_support/time'
require 'hash_with_append'

Date::DATE_FORMATS[:long_sans_year] = "%B %e"

module PivotalTracker
  class Service
    attr_accessor :token
    def initialize(token)
      @token = token
    end
    def req(uri)
      response = RestClient.get uri, 'X-TrackerToken' => @token
      Nokogiri::XML(response.body)
    end
    def project(id)
      Project.new(id, self)
    end
  end
  class Project
    attr_accessor :project, :svc
    def initialize(project, svc)
      @project = project
      @svc = svc
    end
    def activity_doc
      uri = "http://www.pivotaltracker.com/services/v3/projects/#{@project}/activities?limit=100"
      @svc.req uri
    end
    def activities
      activity_doc.search('/activities/activity')
    end
    def user(name)
      User.new(name, self)
    end
  end
  class User
    attr_accessor :user, :svc, :project
    def initialize(user,project)
      @user = user
      @svc = project.svc
      @project = project
      @stories = {}
    end
    def activities
      returning({}) do |acts|
        @project.activities.each do |a|
          next unless (a.at('author').text) == user
          date, act = self.make_act(a, user)
          acts[date] ||= []
          acts[date].unshift(act)
        end
      end
    end
    
    def make_act(activity, subj)
      time = Time.parse(activity.at('occurred_at').text)
      url = activity.at('stories story url').text
      @stories[url] ||= @svc.req(url).at('story')
      act = {
        :desc => activity.at('description').text.gsub(/^#{subj} /,''),
        :author => activity.at('author').text,
        :time => time.to_s(:time),
        :url => @stories[url].at('url').text,
        :name => @stories[url].at('name').text
      }
      [time.to_date, act]
    end
  end
  class Activity
    def self.parse(xml)
      raise "write me"
    end
  end
end