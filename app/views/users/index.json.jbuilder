json.array!(@users) do |user|
  json.extract! user,
  :id,
  :nickname,
  :school,
  :gender,
  :major,
  :speciality,
  :experence,
  :avatar,
  :count_of_followers,
  :count_of_followings
end
