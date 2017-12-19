class Quote < ApplicationRecord
  # Validations
  validates :content, :attribution, presence: true

  # Associations
  belongs_to :topic

  # Lifecycle
  after_initialize :ensure_topic

  def category
    topic ? topic.category : nil
  end

  private

    def ensure_topic
      if !topic || !category
        self.topic = Topic.uncategorizedTopic
      end
    end
end
