module Cybersourcery
  class Payment
    include ActiveModel::Validations

    IGNORE_FIELDS = [:commit, :utf8, :authenticity_token, :action, :controller]

    attr_reader :params, :unsigned_field_names, :signed_date_time

    delegate :config, :sign, to: :Cybersourcery
    delegate :endpoint, to: :config

    def initialize(params)
      @unsigned_field_names = params.delete(:unsigned_field_names) || config.unsigned_field_names
      @signed_date_time = params.delete(:signed_date_time) || Time.now
      @params = params
    end

    def defaults
      {
        profile_id: config.profile_id,
        access_key: config.access_key,
        payment_method: config.payment_method,
        transaction_type: config.transaction_type,
        unsigned_field_names: unsigned_field_names.join(','),
        signed_date_time: signed_date_time.utc.strftime('%Y-%m-%dT%H:%M:%SZ'),
        transaction_uuid: SecureRandom.uuid,
        reference_number: SecureRandom.uuid,
        signed_field_names: nil,
        locale: config.locale
      }
    end

    def signed_params
      data = params.reverse_merge(defaults)

      data.delete_if do |key, _|
        unsigned_field_names.include?(key) || IGNORE_FIELDS.include?(key)
      end

      data[:signed_field_names] = data.keys.join(',')
      data[:signature] = sign(data)
      data
    end

    def fingerprint
      @_fingerprint ||= Fingerprint.new(fingerprint_id) if fingerprint_id
    end

    def fingerprint_id
      params[:device_fingerprint_id]
    end
  end
end
