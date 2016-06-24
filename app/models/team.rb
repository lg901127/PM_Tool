class Team < ActiveRecord::Base
  belongs_to :user
  # has_many :users
  belongs_to :project
  validates :user_id, uniqueness: {scope: :project_id}
end
