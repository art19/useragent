# frozen_string_literal: true

class UserAgent
  module Browsers
    # wondery/develop*
    # wondery/prod*
    # wondery/stag*
    class WonderyCrawler < Base
      WONDERY_CRAWLER       = 'Wondery Crawler'
      WONDERY_CRAWLER_REGEX = /\A(?:develop|prod|stag)/i.freeze

      ##
      # @param agent [Array]
      #     Array of useragent product
      # @return [Boolean]
      #     True if the useragent matches this browser
      def self.extend?(agent)
        agent.detect do |ua|
          UserAgent::Browsers::Wondery::WONDERY_REGEX.match?(ua.product) && WONDERY_CRAWLER_REGEX.match?(ua.version)
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
