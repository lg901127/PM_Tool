class Project < ActiveRecord::Base
  belongs_to :user
  has_many :discussions, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :users, through: :favourites
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :teams, dependent: :nullify
  has_many :team_users, through: :teams, source: :user
  validates :title, presence: true,
                    uniqueness: true
  validate :due_date_greater_than_today


  def favourite_for(user)
    favourites.find_by_user_id user
  end

  def favourite_by?(user)
    favourites.exists?(user: user)
  end

  private

  def due_date_greater_than_today
    if due_date < Date.today
      errors.add(:due_date, "Due date needs to be after today")
    end
  end
end
