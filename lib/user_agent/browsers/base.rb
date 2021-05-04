class UserAgent
  module Browsers
    class Base < Array
      include Comparable

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
        elsif os =~ /Android/
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
