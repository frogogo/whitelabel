# frozen_string_literal: true

class ReceiptValidator::APMCheck < ReceiptValidator::Default
  CHANNEL = 'app'
  META = "poprobuy.ru - #{Rails.env}"
  POST_QR_RECEIPT_PATH = '/api/receipts/qr'
  STATUS_SUCCESS = 'success'
  REJECT_REASONS = {
    'BLOCKED_USER' => :system_error,
    'BRANDS' => :invalid_data,
    'DUPLICATE' => :duplicate,
    'ERROR' => :system_error,
    'EXPIRED' => :invalid_date,
    'FNS_SHORT_CHECK_FAILED' => :invalid_type,
    'FUTURE' => :invalid_date,
    'INCORRECTCITY' => :invalid_data,
    'INCORRECTSTORE' => :invalid_data,
    'MAX_RECEIPTS_PER_DATE' => :invalid_date,
    'MODIFICATION' => :system_error,
    'NOT_ALLOWED_RECEIPT_TYPE' => :invalid_type,
    'NOT_QUANTITY_PRODUCT' => :invalid_data,
    'OUTSIDE_INTERVAL' => :invalid_date,
    'PRODUCTS_PRICE_MAX' => :invalid_sum,
    'PRODUCTS_PRICE_MIN' => :invalid_sum,
    'REJECT_RULES' => :invalid_data,
    'TOTAL_PRODUCTS_COUNT_MIN' => :invalid_sum,
    'TOTAL_PRODUCTS_PRICE_MIN' => :invalid_sum
  }.freeze

  def validate
    response = send_receipt

    if response.body[:status] == STATUS_SUCCESS
      receipt.update!(state: :processing, uuid: response.body[:uuid])
    else
      Rollbar.error("Receipt #{receipt.qr_string} validation failed: #{response.body}")
    end
  end

  private

  def base_url
    Rails.application.credentials.apm_check[:base_url]
  end

  def body
    {
      config: config,
      externalId: receipt.id,
      qrStr: receipt.qr_string,
      usrUuid: user.uuid,
      channel: CHANNEL,
      meta: META
    }
  end

  def config
    {
      callback: {
        url: 'https://poprobuy.ru/apm/callback',
        headers: [{
          name: 'authorization',
          values: [Rails.application.credentials.apm_check[:callback_token]]
        }],
        method: 'POST'
      }
    }.to_json
  end

  def headers
    {
      'api-key' => promotion.api_token,
      'content-type' => 'application/json'
    }
  end

  def send_receipt
    Faraday.post("#{base_url}#{POST_QR_RECEIPT_PATH}", body, headers)
  end
end
