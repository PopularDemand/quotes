class Quote < ApplicationRecord
  # Validations
  validates :content, :attribution, presence: true

  # Associations
  belongs_to :topic

  # Lifecycle
  after_initialize :ensure_topic

  def initialize(args)
    create_topic(args) if create_category(args)
    super(args)
  end

  def category
    topic ? topic.category : nil
  end

  private

    def ensure_topic
      if !topic || !category
        self.topic = Topic.uncategorizedTopic
      end
    end

    def create_topic(args)
      topic = Topic.find_or_create_by(title: args[:topic])
      topic.category = args.delete(:category) { |cat| return cat }
      args[:topic] = topic
    end

    def create_category(args)
      return false unless args[:category] && args[:topic]
      args[:category] = Category.find_or_create_by(title: args[:category])
    end
end
