# frozen_string_literal: true

class UserAgent
  module Browsers
    # Pocket Casts BMID/E678F58F21
    # PocketCasts/1.0 (Pocket Casts Feed Parser; +http://pocketcasts.com/)
    # Shifty Jelly Pocket Casts, Android v4.5.3
    # Shifty Jelly Pocket Casts, iOS v4.3
    # Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Pocket Casts/1.1 Pocket Casts/1.1
    # Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_4) AppleWebKit/537.36 (KHTML, like Gecko) Pocketcast/2.1.0 Chrome/58.0.3029.110 Molecule/2.1.0 Safari/537.36
    # Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Pocketcasts/3.0.11 Chrome/58.0.3029.110 Molecule/3.0.11 Safari/537.36
    # Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) PocketCasts/1.0.0 Chrome/59.0.3071.115 Electron/1.8.3 Safari/537.36
    class PocketCasts < Base
      include DesktopClassifiable

      CASTS                    = 'Casts'
      FEED_PARSER_REGEX        = /Pocket Casts Feed Parser/.freeze
      POCKETCAST               = 'Pocketcast'
      POCKETCASTS              = 'PocketCasts'
      POCKETCASTS_REGEX        = /Pocket[Cc]asts?/.freeze
      POCKET_CASTS             = 'Pocket Casts'
      POCKET_CASTS_REGEX       = /Pocket Casts/.freeze
      POCKET_CASTS_SLASH_REGEX = /Pocket Casts\//.freeze

      ##
      # @param agent [Array]
      #     Array of useragent product
      # @return [Boolean]
      #     True if the useragent matches this browser
      def self.extend?(agent)
        agent.detect { |useragent| POCKETCASTS_REGEX.match?(useragent.product) } || POCKET_CASTS_REGEX.match?(agent.to_s)
      end

      ##
      # @return [String]
      #     The browser name
      def browser
        POCKET_CASTS
      end

      ##
      # @return [Array]
      #     Gets the right application
      def application
        detect_product(POCKETCASTS) || detect_product(POCKETCAST)
      end

      ##
      # @return [Boolean]
      #     True, if this is a bot
      def bot?
        FEED_PARSER_REGEX.match?(to_s)
      end

      ##
      # @return [Boolean]
      #     True, if this is a mobile app
      def mobile?
        return false if bot?

        ANDROID_IOS_REGEX.match?(to_s)
      end

      # Gets the operating system
      #
      # @return [String, nil] the os
      def os
        app = app_with_comments
        return if app.nil? || app.product == POCKETCASTS

        if WINDOWS_NT_REGEX.match?(app.comment[0])
          OperatingSystems.normalize_os(app.comment[0])
        elsif app.comment[2].nil?
          OperatingSystems.normalize_os(app.comment[1])
        elsif ANDROID_REGEX.match?(app.comment[1])
          OperatingSystems.normalize_os(app.comment[1])
        elsif (os_string = app.comment.detect { |c| OperatingSystems::IOS_VERSION_REGEX.match?(c) })
          OperatingSystems.normalize_os(os_string)
        end
      end

      # Gets the platform
      #
      # @return [String, nil] the platform
      def platform
        app = app_with_comments

        if app
          if WINDOWS_REGEX.match?(app.comment[0])
            return WINDOWS
          elsif MACINTOSH_REGEX.match?(app.comment[0])
            return MACINTOSH
          elsif app.comment.any? { |c| ANDROID_REGEX.match?(c) }
            return ANDROID
          end
        end

        ua = self.to_s
        if ANDROID_REGEX.match?(ua)
          ANDROID
        elsif IOS_REGEX.match?(ua)
          IOS
        end
      end

      # Gets the version
      #
      # @return [String]
      def version
        if application && application.version
          version = application.version.to_s
          return version.index('/') ? normalize_version(version.split('/')[-1]) : normalize_version(application.version)
        end

        ua = self.to_s
        if pos = ua =~ ANDROID_REGEX
          normalize_version(ua[pos..-1].split[1])
        elsif pos = ua =~ IOS_REGEX
          normalize_version(ua[pos..-1].split[1])
        elsif POCKET_CASTS_SLASH_REGEX.match?(ua)
          normalize_version(detect_product(CASTS).version)
        end
      end

      private

      # Normalize the version string
      # - remove starting 'v'
      def normalize_version(version)
        version = version.to_s
        return version[1..-1] if version.downcase.start_with?('v')
        version
      end
    end
  end
end
