class Topic < ApplicationRecord
  # Validations
  validates_presence_of :title

  # Associations
  has_many :quotes, counter_cache: true
  belongs_to :category

  # Lifecycle
  before_save :downcase_title

  # Class methods
  def self.uncategorizedTopic
    topic = self.find_by(title: 'uncategorized')
    topic ? topic : create_uncategorized_topic
  end

  private

    def downcase_title
      self.title = self.title.downcase
    end

    # Class methods
    def self.create_uncategorized_topic
      category = Category.find_or_create_by(title: 'uncategorized')
      Topic.create(title: 'uncategorized', category: category)
    end
end