begin
  # Try to require the preresolved locked set of gems.
  require File.expand_path('../.bundle/environment', __FILE__)
rescue LoadError
  # Fall back on doing an unlocked resolve at runtime.
  require "rubygems"
  require "bundler"
  Bundler.setup
end

lib_path = File.expand_path("../lib",__FILE__)
$:.unshift lib_path unless $:.include? lib_path

require 'rest_client'
require 'nokogiri'
require 'active_support/time'
require 'active_support/core_ext/object/returning'
require 'active_support/core_ext/hash/slice'
require 'hash_with_append'

Date::DATE_FORMATS[:long_sans_year] = "%B %e"

class Projects < Thor
  def initialize(*args)
    @stories = {}
    super(*args)
  end
  desc "tracker", "get tracker data"
  def tracker
    acts = for_subj("Joseph Holsten")
    puts render(acts)
  end
  
  no_tasks do
    def req(uri)
      token = 'dc5a8bb8ea76ac8363eb80fbf5ae4c42'
      response = RestClient.get uri, 'X-TrackerToken' => token
      Nokogiri::XML(response.body)
    end
    def activities
      project_id = '30500'
      uri = "http://www.pivotaltracker.com/services/v3/projects/#{project_id}/activities?limit=100"

      doc = req uri
      activities = doc.search('/activities/activity')
    end
    def for_subj(subj)
      returning({}) do |acts|
        activities.each do |a|
          next unless (author = a.at('author').text) == subj
          date, act = make_act(a, subj)
          acts[date] ||= []
          acts[date].unshift(act)
        end
      end
    end
    def make_act(activity, subj)
      time = Time.parse(activity.at('occurred_at').text)
      url = activity.at('stories story url').text
      @stories[url] ||= req(url).at('story')
      act = {
        :desc => activity.at('description').text.gsub(/^#{subj} /,''),
        :author => activity.at('author').text,
        :time => time.to_s(:time),
        :url => @stories[url].at('url').text,
        :name => @stories[url].at('name').text
      }
      [time.to_date, act]
    end
    def render(activities)
      out = StringIO.new
      activities.keys.sort.each do |day|
        out.puts day.to_s(:long_sans_year)
        stories = activities[day].sort_by{|s| s[:time] }
        out.puts "\nStories"
        stories.map{|s| s.slice(:url, :name) }.uniq.each do |s|
          out.puts "* <a href=\"#{s[:url]}\">#{s[:name]}</a>"
        end

        out.puts "\nActivities"
        stories.each do |s|
          out.puts "#{s[:time]} #{s[:desc]}"
        end
        out.puts "\n\n"
      end
      out.rewind
      out.read
    end
  end
end