module Assignable
  extend ActiveSupport::Concern

  ASSIGN_TIME = 60.seconds
  UNASSIGN_TIME = 10.seconds
  UNASSIGN_OBJECT_ID = 0

  attr_reader :user_to_assign

  def assign(user)
    @user_to_assign = user

    assign_to_user
    interact_with_vending_machine_interface
    @user_to_assign.set_assign_time_limit
  end

  def unassign(user)
    @user_to_assign = user

    Rails.cache.write(
      assign_key,
      {
        expires_at: Time.current + UNASSIGN_TIME,
        object_class: user_to_assign.class.name.parameterize,
        object_id: UNASSIGN_OBJECT_ID
      },
      expires_in: UNASSIGN_TIME
    )
  end

  def assigned_expires_at
    assign_value[:expires_at]
  end

  def assigned?(user)
    assign_value[:object_class] == user.class.name.parameterize &&
      assign_value[:object_id] == user.id
  end

  def busy?
    assign_value[:object_id].present?
  end

  private

  def assign_to_user
    Rails.cache.write(
      assign_key,
      {
        expires_at: Time.current + ASSIGN_TIME,
        object_class: user_to_assign.class.name.parameterize,
        object_id: user_to_assign.id
      },
      expires_in: ASSIGN_TIME
    )
  end

  def interact_with_vending_machine_interface
    VendingMachineInterface.assign(self, user_to_assign)
  end

  # Keys

  def assign_key
    "#{self.class.name.parameterize}:#{id}:assigned"
  end

  # Values

  def assign_value
    @assign_value ||= Rails.cache.read(assign_key) || {}
  end
end
