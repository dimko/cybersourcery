module Cybersourcery
  class Profile
    attr_reader :config

    def initialize(options = {})
      @config = Cybersourcery.config.inheritable_copy

      options.each do |key, value|
        config[key] = value
      end
    end

    def payment(params)
      Cybersourcery::Payment.new(self, params)
    end

    def sign(params, keys = nil)
      Signer.new(secret_key, params, keys || params.keys).signature
    end

    def secret_key
      "#{config.secret_key}"
    end
  end
end
