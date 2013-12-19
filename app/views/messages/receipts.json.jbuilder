json.array! @receipts do |receipt|
  json.extract! receipt,
  :id,
  :content

  json.sender do
    json.extract! receipt.sender,
    :id,
    :email,
    :nickname,
    :gender,
    :contact,
    :school,
    :major,
    :speciality,
    :experence,
    :avatar,
    :count_of_followers,
    :count_of_followings,
    :last_login_time
  end

end
