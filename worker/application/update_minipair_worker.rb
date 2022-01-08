# frozen_string_literal: true

require_relative '../../init.rb'
require 'aws-sdk-sqs'

module CodePraise
  # Scheduled worker to report on recent cloning operations
  class UpdateMinipairWorker
    def initialize
      @config = UpdateMinipairWorker.config
      @minipairs = Binance::SignalsListMapper.new.get_sortlist().signals
    end

    def call
      puts "REPORT DateTime: #{Time.now}"

      # Notify administrator of unique clones
      if cloned_projects.any?
        # TODO: Email administrator instead of printing to STDOUT
        puts "\tNumber of unique repos cloned: #{cloned_projects.count}"
        puts "\tTotal disk space: #{total_size}"
      else
        puts "\tNo cloning reported in this period"
      end
    end

      @cloned_projects.tap { puts }
    end

    def total_size
      cloned_projects.values.reduce(0) { |size, project| size + project.size }
    end
  end
end