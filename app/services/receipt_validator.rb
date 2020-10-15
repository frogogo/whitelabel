module ReceiptValidator
  def self.validate(receipt)
    validator = ReceiptValidator::APMCampaignValidator
    validator.new(receipt).validate
  end
end
