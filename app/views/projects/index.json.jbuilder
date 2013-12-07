json.data do
  json.array!(@projects) do |project|
    json.extract! project,
    :id,
    :title,
    :school,
    :state,
    :count_of_likes,
    :count_of_views,
    :created_at,
    :updated_at

    json.tags project.tags, :name

    json.members project.users,
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
json.total_pages @projects.total_pages if @projects.respond_to?(:total_pages)
