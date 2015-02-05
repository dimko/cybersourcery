require 'openssl'
require 'base64'

module Cybersourcery
  class Signer
    attr_reader :params, :keys

    delegate :secret_key, to: 'Cybersourcery.config'

    def initialize(params, keys)
      @params = params
      @keys = keys
    end

    def signature
      Base64.strict_encode64(digest)
    end

    def digest
      OpenSSL::HMAC.digest(sha256, secret_key, message)
    end

    private

    def message
      keys.map { |key| "#{key}=#{params[key]}" }.join(',')
    end

    def sha256
      OpenSSL::Digest.new('sha256')
    end
  end
end
