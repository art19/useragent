# frozen_string_literal: true

class UserAgent
  module Browsers
    # wondery/develop
    # wondery/production
    # wondery/staging
    class WonderyCrawler < Base
      WONDERY_CRAWLER          = 'Wondery Crawler'
      WONDERY_CRAWLER_VERSIONS = %w[develop production staging].freeze

      ##
      # @param agent [Array]
      #     Array of useragent product
      # @return [Boolean]
      #     True if the useragent matches this browser
      def self.extend?(agent)
        agent.detect do |ua|
          UserAgent::Browsers::Wondery::WONDERY_REGEX.match?(ua.product) &&
            WONDERY_CRAWLER_VERSIONS.include?(ua.version)
        end
      end

      ##
      # @return [Boolean]
      #     This is a bot
      def bot?
        true
      end

      ##
      # @return [String]
      #     The browser name
      def browser
        WONDERY_CRAWLER
      end
    end
  end
end
