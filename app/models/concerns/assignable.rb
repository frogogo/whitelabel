module Assignable
  extend ActiveSupport::Concern

  ASSIGN_TIME = 60.seconds

  def assign(object)
    Rails.cache.write(assign_key, object.id, expires_in: ASSIGN_TIME)

    VendingMachineInterface.assign(self, object) if self.class == VendingMachine
  end

  def assigned?(object)
    assign_value == object.id
  end

  def busy?
    assign_value.positive?
  end

  private

  def assign_key
    "#{self.class.name.parameterize}:#{id}:assigned"
  end

  def assign_value
    @assign_value ||= Rails.cache.read(assign_key) || 0
  end
end
