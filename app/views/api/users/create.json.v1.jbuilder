json.extract! @user, :phone_number
json.password_lifetime User::PASSWORD_LIFETIME.to_i
json.status :created
