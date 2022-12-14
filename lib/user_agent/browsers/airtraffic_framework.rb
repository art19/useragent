# frozen_string_literal: true

class UserAgent
  module Browsers
    ##
    # This class detects and handles the ATC browser on Apple Watch
    class AirTrafficFramework < Base
      # The browser string
      BROWSER = 'AirTraffic.framework'

      # The build within the comment
      BUILD = 'build'

      # The product string identifying the AirTraffic.framework browser
      PRODUCT_ATC = 'atc'

      # The product string identifying the broken versions of this browser
      PRODUCT_NULL = '(null)'

      ##
      # Check if this class is usable for at least one of the provided user agents
      #
      # @param agents [UserAgent::Browsers::Base]
      #     List of user agents to figure out if it could be an ATC browser on Apple Watch
      #
      # @return [Boolean]
      #     true, if this is the right class for the user agent
      def self.extend?(agents)
        agents.find { |user_agent| user_agent.product.casecmp(PRODUCT_ATC).zero? } ||
          agents.find { |user_agent| user_agent.product.casecmp(PRODUCT_NULL).zero? } &&
          agents.find { |user_agent| user_agent.product.casecmp(WATCH_OS).zero? }
      end

      ##
      # @return [String] Reports the AirTraffic.framework browser
      def browser
        BROWSER
      end

      ##
      # @return [Array]
      #     Gets DARWIN product informaton
      def darwin_application
        detect_product(DARWIN)
      end

      ##
      # @return [Boolean]
      #    This is mobile when platform is iOS or Apple Watch
      def mobile?
        [APPLE_WATCH, IOS].include?(platform)
      end

      ##
      # @return [String, nil]
      #    The operating system with the detected version of the product
      def os
        case platform
        when APPLE_TV
          darwin_app = darwin_application
          if darwin_app && darwin_app.version
            [TVOS, OperatingSystems::Darwin::TV_OS[darwin_app.version.to_s]].compact.join(' ')
          else
            ua = detect_product(APPLE_TV) || detect_product(APPLETV) || detect_product(TVOS)
            "#{TVOS} #{ua&.version}".strip
          end
        when APPLE_WATCH
          ua = detect_product(WATCH_OS)
          "#{WATCH_OS} #{ua&.version}".strip
        when MACINTOSH
          darwin_app = darwin_application
          if darwin_app && darwin_app.version
            [MAC_OS, OperatingSystems::Darwin::MAC_OS[darwin_app.version.to_s]].compact.join(' ')
          else
            MAC_OS
          end
        when IOS
          darwin_app = darwin_application
          if darwin_app && darwin_app.version
            [IOS, OperatingSystems::Darwin::IOS[darwin_app.version.to_s]].compact.join(' ')
          else
            IOS
          end
        end
      end

      ##
      # @return [String, nil] The detected platform
      def platform
        ua = to_s
        case ua
        when APPLE_TV_REGEX, TVOS_REGEX
          APPLE_TV
        when APPLE_WATCH_REGEX, WATCH_OS_REGEX
          APPLE_WATCH
        when IOS_REGEX
          IOS
        else
          app = darwin_application
          if app && !(app.comment && app.comment.any? { |c| X86_64_REGEX.match?(c) })
            IOS
          elsif app
            MACINTOSH
          end
        end
      end

      ##
      # @return [UserAgent::Version, nil] The browser version
      def version
        atc_version   = detect_product(PRODUCT_ATC)&.version
        build_version = detect_product(BUILD)&.version

        return atc_version unless atc_version && build_version

        UserAgent::Version.new("#{atc_version}.#{build_version}")
      end
    end
  end
end
