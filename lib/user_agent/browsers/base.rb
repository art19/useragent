# frozen_string_literal: true

class UserAgent
  module Browsers
    class Base < Array
      include Comparable

      ANDROID           = 'Android'
      APPLE_WATCH       = 'Apple Watch'
      DALVIK            = 'Dalvik'
      DARWIN            = 'Darwin'
      HOME_POD_SOFTWARE = 'HomePod Software'
      IOS               = 'iOS'
      IPAD              = 'iPad'
      IPHONE            = 'iPhone'
      IPODTOUCH         = 'iPod_touch'
      IPOD_TOUCH        = 'iPod touch'
      LINUX             = 'Linux'
      MACINTOSH         = 'Macintosh'
      MAC_OS            = 'macOS'
      MOZILLA           = 'Mozilla'
      OSX               = 'OSX'
      WATCH_OS          = 'watchOS'
      WINDOWS           = 'Windows'
      X11               = 'X11'

      ANDROID_IOS_REGEX = /(Android|iOS)/.freeze
      ANDROID_REGEX     = /[Aa]ndroid/.freeze
      APPLE_WATCH_REGEX = /Apple Watch/.freeze
      DARWIN_REGEX      = /Darwin/.freeze
      IOS_REGEX         = /iOS/.freeze
      IPAD_REGEX        = /iPad/.freeze
      IPHONE_REGEX      = /iPhone/.freeze
      IPOD_REGEX        = /iPod/.freeze
      MACINTOSH_REGEX   = /Macintosh/.freeze
      OS_X_REGEX        = /OS X/.freeze
      WATCH_OS_REGEX    = /watchOS/.freeze
      WINDOWS_NT_REGEX  = /Windows NT/.freeze
      WINDOWS_REGEX     = /Windows/.freeze
      X11_REGEX         = /X11/.freeze
      X86_64_REGEX      = /x86_64/.freeze

      def <=>(other)
        if respond_to?(:browser) && other.respond_to?(:browser) &&
            browser == other.browser
          version <=> Version.new(other.version)
        else
          false
        end
      end

      def eql?(other)
        self == other
      end

      def to_s
        to_str
      end

      def to_str
        join(" ")
      end

      def application
        first
      end

      ##
      # @return [Array, nil]
      #     The first application that has comments
      def app_with_comments
        reject { |agent| agent.comment.nil? || agent.comment.empty? }.first
      end

      def browser
        application && application.product
      end

      def version
        application && application.version
      end

      def platform
        nil
      end

      def os
        nil
      end

      def respond_to?(symbol, include_all = false)
        detect_product(symbol) ? true : super
      end

      def method_missing(method, *args, &block)
        detect_product(method) || super
      end

      def mobile?
        if detect_product('Mobile') || detect_comment('Mobile')
          true
        elsif ANDROID_IOS_REGEX.match?(os)
          true
        elsif application && application.detect_comment { |c| c =~ /^IEMobile/ }
          true
        else
          false
        end
      end

      def bot?
        # If UA has no application type, its probably generated by a
        # shitty bot.
        if application.nil?
          true
        # Match common case when bots refer to themselves as bots in
        # the application comment. There are no standards for how bots
        # should call themselves so its not an exhaustive method.
        #
        # If you want to expand the scope, override the method and
        # provide your own regexp. Any patches to future extend this
        # list will be rejected.
        elsif detect_comment_match(/bot/i)
          true
        elsif product = application.product
          product.include?('bot')
        else
          false
        end
      end

      ##
      # @return [Boolean] True if this UA is a desktop
      def desktop?
        false
      end

      ##
      # @return [Boolean] True if this UA is a speaker
      def speaker?
        false
      end

      def to_h
        return unless application

        hash = {
          :browser  => browser,
          :platform => platform,
          :os       => os,
          :mobile   => mobile?,
          :bot      => bot?,
          :desktop  => desktop?,
          :speaker  => speaker?,
        }

        if version
          hash[:version] = version.to_a
        else
          hash[:version] = nil
        end

        if comment = application.comment
          hash[:comment] = comment.dup
        else
          hash[:comment] = nil
        end

        hash
      end

      private
        def detect_product(product)
          detect { |useragent| useragent.product.to_s.downcase == product.to_s.downcase }
        end

        def detect_comment(comment)
          detect { |useragent| useragent.detect_comment { |c| c == comment } }
        end

        def detect_comment_match(regexp)
          comment_match = nil
          detect { |useragent| useragent.detect_comment { |c| comment_match = c.match(regexp) } }
          comment_match
        end
    end
  end
end
