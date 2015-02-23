module Cybersourcery
  class Payment
    class Fingerprint
      attr_reader :id

      delegate :config, to: :Cybersourcery

      def initialize(id)
        @id = id
      end

      def org
        config.fingerprint_org
      end

      def endpoint
        config.fingerprint_endpoint
      end

      def sid
        "#{config.merchant}#{id}"
      end
    end
  end
end
