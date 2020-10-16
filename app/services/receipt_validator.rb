# frozen_string_literal: true

module ReceiptValidator
  def self.validate(receipt)
    validator = ReceiptValidator::APMCampaign
    validator.new(receipt).validate
  end
end
