module Cybersourcery
  class Payment
    include ActiveModel::Validations

    IGNORE_FIELDS = [:commit, :utf8, :authenticity_token, :action, :controller]

    attr_reader :params

    delegate :config, :sign, to: :Cybersourcery
    delegate :endpoint, to: :config

    def initialize(params)
      @params = params
    end

    def default_params
      {
        profile_id: config.profile_id,
        access_key: config.access_key,
        payment_method: config.payment_method,
        transaction_type: config.transaction_type,
        locale: config.locale
      }
    end

    def signed_params
      data = default_params.reverse_merge \
        unsigned_field_names: config.unsigned_field_names.join(','),
        transaction_uuid: SecureRandom.uuid,
        reference_number: SecureRandom.uuid,
        signed_date_time: current_time,
        signed_field_names: nil

      data.delete_if do |key, _|
        config.unsigned_field_names.include?(key) || IGNORE_FIELDS.include?(key)
      end

      data[:signed_field_names] = data.keys.join(',')
      data[:signature] = sign(data)
      data
    end

    def current_time
      Time.now.utc.strftime('%Y-%m-%dT%H:%M:%SZ')
    end
  end
end
