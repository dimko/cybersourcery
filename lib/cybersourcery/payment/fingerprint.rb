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

      def domain
        config.fingerprint_domain
      end

      def sid
        "#{config.merchant}#{id}"
      end
    end
  end
end
