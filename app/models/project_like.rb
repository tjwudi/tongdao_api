class ProjectLike < ActiveRecord::Base
  belongs_to :user
  belongs_to :project, counter_cache: :count_of_project_likes
end
