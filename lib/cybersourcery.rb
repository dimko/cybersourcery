require 'active_support'

require 'cybersourcery/payment'
require 'cybersourcery/payment/fingerprint'
require 'cybersourcery/signer'
require 'cybersourcery/version'

module Cybersourcery
  extend self

  include ActiveSupport::Configurable

  config_accessor(:endpoint) { 'https://testsecureacceptance.cybersource.com/silent/pay' }
  config_accessor(:profile_id, :access_key, :secret_key, :merchant, :merchant_name)
  config_accessor(:transaction_type) { 'sale' }
  config_accessor(:payment_method) { 'card' }
  config_accessor(:locale) { 'en-us' }

  config_accessor(:fingerprint_domain) { 'h.online-metrix.net' }
  config_accessor(:fingerprint_org) { '1snn5n9w' }

  config_accessor(:unsigned_field_names) do
    [
      :bill_to_forename,
      :bill_to_surname,
      :bill_to_address_country,
      :bill_to_address_state,
      :bill_to_address_city,
      :bill_to_address_line1,
      :bill_to_address_postal_code,
      :bill_to_email,
      :card_cvn,
      :card_expiry_date,
      :card_number,
      :card_type,
      :amount
    ]
  end

  def sign(params, keys = nil)
    Signer.new(params, keys || params.keys).signature
  end
end
