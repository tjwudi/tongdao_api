json.array! @conversations do |conversation|
  json.extract! conversation,
  :id,
  :is_read

  json.user_opp do
    json.extract! conversation.user_opp,
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
