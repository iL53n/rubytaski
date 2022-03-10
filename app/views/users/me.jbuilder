json.user do
  json.extract! @user,
    :id,
    :email,
    :nick_name,
    :date_of_birth,
    :locale,
    :parent,
    :created_at
end
