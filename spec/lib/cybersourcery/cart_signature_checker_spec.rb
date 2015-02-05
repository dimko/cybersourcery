require 'rails_helper'

describe Cybersourcery::CartSignatureChecker do
  let(:profile) do
    double :profile, profile_id: 'pwksgem', secret_key: 'SECRET_KEY'
  end

  let(:signature) { 'vWV/HxXelIWsO0tkLZe+H1S6tXflgPz79udP0uXrvPI=' }

  let(:params) do
    {
      'access_key' => 'ACCESS_KEY',
      'profile_id' => 'pwksgem',
      'payment_method' => 'sale',
      'foo' => 'bar'
    }
  end

  let(:session) do
    {
      signed_cart_fields: 'access_key,profile_id,payment_method',
      cart_signature:     signature
    }
  end

  describe '#run!' do
    it 'does not raise an exception when the signatures match' do
      checker = described_class.new(
        profile: profile, params: params, session: session
      )
      expect(checker.run!).to be_nil
    end

    it 'raises an exception when the signatures do not match' do
      params['access_key'] = 'TAMPERED_KEY'

      checker = described_class.new(
        profile: profile, params: params, session: session
      )

      expect { checker.run! }.to raise_exception(
        Cybersourcery::Error,
        'Detected possible data tampering. Signatures do not match.'
      )
    end
  end
end
