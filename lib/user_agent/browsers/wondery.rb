# frozen_string_literal: true

require 'set'

class UserAgent
  module Browsers
    # Browser is "Wondery" for:
    # wondery/android/v1.8.2/2314
    # Wondery/1660 CFNetwork/1183 Darwin/20.0.0
    # wondery/ios/v1.8.2/48
    # wondery/ios/v1.4.2/1, AppleCoreMedia/1.0.0.17G64 (iPhone; U; CPU OS 13_6 like Mac OS X; en_us)
    #
    # Browser is "Wondery Crawler" for:
    # wondery/develop
    # wondery/development
    # wondery/prod
    # wondery/production
    # wondery/stage
    # wondery/staging
    class Wondery < Base
      IOS_LOWER_REGEX          = /ios/.freeze
      WONDERY                  = 'Wondery'
      WONDERY_CRAWLER          = 'Wondery Crawler'
      WONDERY_CRAWLER_VERSIONS = Set.new(%w[develop development prod production stage staging]).freeze
      WONDERY_REGEX            = /[Ww]ondery/.freeze

      ##
      # @param agent [Array]
      #     Array of useragent product
      # @return [Boolean]
      #     True if the useragent matches this browser
      def self.extend?(agent)
        agent.detect { |useragent| WONDERY_REGEX.match?(useragent.product) }
      end

      ##
      # @return [Boolean]
      #     true if this is a bot/crawler
      def bot?
        WONDERY_CRAWLER_VERSIONS.include?(version)
      end

      ##
      # @return [String]
      #     The browser name
      def browser
        return WONDERY_CRAWLER if bot?

        WONDERY
      end

      ##
      # @return [Boolean]
      #     true if this is a mobile app
      def mobile?
        !bot?
      end

      # Gets the operating system
      #
      # @return [String, nil] the os
      def os
        app = detect_product(DARWIN)
        return [IOS, UserAgent::OperatingSystems::Darwin::IOS[app.version.to_s]].compact.join(' ') if app

        app = app_with_comments
        return OperatingSystems.normalize_os(app.comment.join) if app
      end

      # Gets the platform
      #
      # @return [String, nil] the platform
      def platform
        return if bot?

        ua = to_s

        case ua
        when ANDROID_REGEX
          ANDROID
        when IPHONE_REGEX
          IPHONE
        when IPAD_REGEX
          IPAD
        when IPOD_REGEX
          IPOD_TOUCH
        when DARWIN_REGEX, IOS_LOWER_REGEX
          IOS
        end
      end

      ##
      # @return [String] the app version
      def version
        normalize_version(application.version)
      end

      private

      ##
      # Normalize the version
      #   - remove platform
      #   - remove starting 'v'
      #
      # @param version [Version]
      #     The application version
      # @return [String]
      #     normalized version
      def normalize_version(version)
        v     = version.to_s.downcase
        parts = v.split('/')
        v     = parts[1] unless parts[1].nil?
        v.start_with?('v') ? v[1..-1] : v
      end
    end
  end
end
