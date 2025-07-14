class UserAgent
  module Browsers
    class Samsung < Webkit

      SAMSUNG_BROWSER = 'SamsungBrowser'

      def self.extend?(agent)
        agent.detect { |useragent| useragent.product == SAMSUNG_BROWSER }
      end

      def version
        self.detect { |useragent| useragent.product == SAMSUNG_BROWSER }.version
      end

      ##
      # @return [Boolean]
      #     SamsungBrowser is a mobile device
      def mobile?
        true
      end

      def browser
        'Samsung Internet Browser'
      end

      def web_browser?
        true
      end
    end
  end
end
