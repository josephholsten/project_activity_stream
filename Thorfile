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
require 'active_support/core_ext/hash/slice'
require 'streamy'

# Replace These
PIVOTAL_TOKEN = '00000000000000000000000000000000'
GITHUB_TOKEN = {:login => 'jappleseed', :token => '00000000000000000000000000000000'}

class Projects < Thor
  def initialize(*args)
    @stories = {}
    super(*args)
  end
  desc "tracker", "get tracker data"
  def tracker
    user = PivotalTracker::Service.new(PIVOTAL_TOKEN).
      project('30500').
      user("Joseph Holsten")
    puts render(user.activities)
  end
  
  desc 'github', "get github commits"
  def github
    cmts = cmts_for_author "Joseph Anthony Pasquale Holsten"
    puts render_github(cmts)
  end
    
  
  no_tasks do
    def cmts_for_author(author)
      uri = 'https://github.com/api/v2/xml/commits/list/mobicentric/mobicentric/master'
      resp = RestClient.post uri, GITHUB_TOKEN
      commits = Nokogiri::XML(resp.body).search('/commits/commit')
      cmts = {}
      commits.each do |commit|
        next unless commit.at('author name').text == author

        time = Time.parse(commit.at('authored-date').text)
        date = time.to_date
        cmt = {
          :author => commit.at('author name').text,
          :url => commit.at('url').text,
          :time => time.to_s(:time),
          :desc => commit.at('message').text.lines.first.strip
        }
        cmts[date] ||= []
        cmts[date].unshift(cmt)
      end
      cmts
    end
    def render_github(cmts)
      out = StringIO.new
      cmts.keys.sort.each do |day|
        out.puts day.to_s(:long_sans_year)
        commits = cmts[day].sort_by{|s| s[:time] }
        out.puts "\nCommits"
        commits.each do |s|
          out.puts "#{s[:time]} <a href=\"#{s[:url]}\">#{s[:desc]}</a>"
        end
        out.puts "\n\n"
      end
      out.rewind
      out.read
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