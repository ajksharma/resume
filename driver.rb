#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
require 'date'
Bundler.require

Resume::Base.new File.join(File.dirname(__FILE__), 'resume.rl')
