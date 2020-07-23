json.extract! @user, :phone_number
json.password_refresh_rate User::PASSWORD_REFRESH_RATE.to_i
json.status :created
