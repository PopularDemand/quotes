class Quote < ApplicationRecord
  # Validations
  validates :content, :attribution, :topic, presence: true

  # Associations
  belongs_to :topic

  # Lifecycle
  after_initialize :ensure_topic

  def initialize(args)
    Quote.convert_association_strings(args)
    super(args)
  end

  def category
    topic ? topic.category : nil
  end

  def to_json(opts = {})
    {
      id: id,
      content: content,
      attribution: attribution,
      category: category.title,
      topic: topic.title
    }
  end

  def self.convert_association_strings(args)
    self.create_category(args)
    self.create_topic(args)
    args
  end

  private

    def ensure_topic
      if !topic || !category
        self.topic = Topic.uncategorizedTopic
      end
    end

    def self.create_topic(args)
      if !args[:topic]
        return args[:topic] = Topic.uncategorizedTopic
      end

      title = args[:topic].downcase
      category = args.delete(:category) { |cat| return cat }
      new_topic = Topic.find_or_create_by(title: title, category: category)
      args[:topic] = new_topic
    end

    def self.create_category(args)
      if !args[:category]
        return args[:category] = Category.uncategorizedCategory
      end

      title = args[:category].downcase
      args[:category] = Category.find_or_create_by(title: title)
    end
end
