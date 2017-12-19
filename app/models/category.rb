class Category < ApplicationRecord
  # Validation
  validates_presence_of :title

  # Associations
  has_many :topics
  has_many :quotes, through: :topics

  # Lifecycle
  before_save :downcase_title

  private

    def downcase_title
      self.title = self.title.downcase
    end
end