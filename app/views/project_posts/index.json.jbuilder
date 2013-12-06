json.array!(@project_posts) do |project_post|

  json.extract! project_post,
  :id,
  :created_at,
  :updated_at,
  :title,
  :content

end
