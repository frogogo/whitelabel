json.extract! @user, :email, :first_name, :phone_number
json.is_new @user.new?
json.jwt @token
