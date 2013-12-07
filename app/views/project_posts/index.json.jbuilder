json.data do
  json.array!(@project_posts) do |project_post|

    json.extract! project_post,
    :id,
    :created_at,
    :updated_at,
    :title,
    :content

  end
end
json.total_pages @project_posts.total_pages if @project_posts.respond_to?(:total_pages)
