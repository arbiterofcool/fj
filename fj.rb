#!/usr/bin/env ruby

require 'rubygems'
require 'jira'
require 'commander/import'
require 'pp'

program :version, '0.0.1'
program :description, '4jk'

command :az do |c|
  c.syntax = 'fj az [options]'
  c.summary = ''
  c.description = ''
  c.example 'description', 'command example'
  c.option '-s', 'Some switch that does something'
  c.action do |args, options|
    # Do something or c.when_called Fj::Commands::Gf
    puts
  end
end

command :gf do |c|
  c.syntax = 'fj gf [options]'
  c.summary = ''
  c.description = ''
  c.example 'description', 'command example'
  c.option '--some-switch', 'Some switch that does something'
  c.action do |args, options|
    # Do something or c.when_called Fj::Commands::Gf
    puts "fuqueue"

    options = {
        :username => ENV['JIRA_USERNAME'],
        :password => ENV['JIRA_PASSWORD'],
        :site     => ENV['JIRA_URL'],
        :context_path => '',
        :auth_type => :basic
    }
    client = JIRA::Client.new(options)

    if options['-b']
      prefix = '[BUGFIX] '
    elsif options['-f']
      prefix = '[FEATURE] '
    else
      prefix = ''
    end


    client.Issue.jql('filter = "fj"').each do |issue|
      puts prefix + "#{issue.key} - #{issue.fields['summary']}"
      puts issue.assignee.name
    end


    # project = client.Project.find('BINGOFLASH')
    # pp project
    # i = 1
    # project.issues.each do |issue|
    #   puts i.to_s + ": #{issue.key} - #{issue.fields['summary']}"
    # end

    # username = "schatman"
    # password = "Compass210180$"
    #
    # options = {
    #     :username => username,
    #     :password => password,
    #     :site     => 'http://titangaming.atlassian.net/',
    #     :auth_type => :basic
    # }
    #
    # client = JIRA::Client.new(options)
    #Show all projects
    # projects = client.Project.all
    #
    # projects.each do |project|
    #   puts "Project -> key: #{project.key}, name: #{project.name}"
    # end
  end
end