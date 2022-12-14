# frozen_string_literal: true

class UserAgent
  module Browsers
    ##
    # This class detects and handles the Pod2Watch browser on Apple Watch
    class Pod2Watch < Base
      # The Pod2Watch browser
      BROWSER = 'Pod2Watch'

      # The darwin product (providing a kernel version)
      DARWIN = 'Darwin'

      # The Operating System
      WATCH_OS = 'watchOS'

      # The platform for browsers on Apple Watch
      PLATFORM = 'Apple Watch'

      ##
      # Check if this class is usable for at least one of the provided user agents
      #
      # @param agents [UserAgent::Browsers::Base]
      #     List of user agents to figure out if it could be a Pod2Watch browser on Apple Watch
      #
      # @return [Boolean]
      #     true, if this is the right class for the user agent
      def self.extend?(agents)
        agents.first.product.start_with?(BROWSER) if agents.size.positive?
      end

      ##
      # @return [Boolean] false, Apple Watch is not considered a bot
      def bot?
        false
      end

      ##
      # @return [String]
      #     The browser name
      def browser
        BROWSER
      end

      ##
      # @return [Boolean] true -- An Apple Watch is always mobile
      def mobile?
        true
      end

      ##
      # The operating system is derived from the Darwin kernel version when present,
      # otherwise pulled from the comment.
      #
      # @return [String] The operating system
      def os
        darwin  = detect_product(DARWIN)
        version = if darwin
                    UserAgent::OperatingSystems::Darwin::WATCH_OS[darwin.version.to_s]
                  else
                    match = detect_comment_match(/watchOS\s(?<version>[\.\d]+)/)
                    match.named_captures['version'] if match
                  end

        [WATCH_OS, version].compact.join(' ')
      end

      ##
      # @return [String] The platform
      def platform
        PLATFORM
      end

      ##
      # @return [UserAgent::Version, nil] The browser version
      def version
        find { |agent| !agent.version.nil? }&.version
      end
    end
  end
end
