json.extract! @user, :email, :first_name, :phone_number, :refresh_token
json.is_new @user.new?
json.jwt @token
