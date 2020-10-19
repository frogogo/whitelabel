# frozen_string_literal: true

module ReceiptValidator
  def self.validate(receipt)
    validator = ReceiptValidator::APMCheck
    validator.new(receipt).validate
  end
end
