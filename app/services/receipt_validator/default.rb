# frozen_string_literal: true

class ReceiptValidator::Default
  def initialize(receipt)
    @receipt = receipt
    @promotion = receipt.promotion
    @user = receipt.user
  end

  def validate
    raise NotImplementedError
  end

  private

  attr_reader :promotion, :receipt, :user
end
