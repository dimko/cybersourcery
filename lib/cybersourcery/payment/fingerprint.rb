module Cybersourcery
  class Payment
    class Fingerprint
      attr_reader :profile, :id

      delegate :config, to: :profile

      def initialize(profile, id)
        @profile = profile
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
