json.array!(@project_comments) do |project_comment|
  json.extract! project_comment,
  :id,
  :content,
  :emotion

  json.user do
    json.extract! project_comment.user,
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
