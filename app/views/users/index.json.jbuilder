json.data do
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
end
json.total_pages @users.total_pages if @users.respond_to?("total_pages")
