class ReceiptValidator::DefaultValidator
  def initialize(promotion, receipt)
    @promotion = promotion
    @receipt = receipt
    @user = receipt.user
  end

  def validate
    raise NotImplementedError
  end

  private

  attr_reader :promotion, :receipt, :user
end
