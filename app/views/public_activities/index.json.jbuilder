json.array!(@public_activities) do |public_activity|
  json.extract! public_activity,
  :id,
  :data,
  :created_at,
  :updated_at

  json.user do
    json.extract! public_activity.user,
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
end
