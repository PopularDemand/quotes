quotes = [
  {
    topic: 'keeping it simple',
    category: 'humor',
    content: 'Smile. It confuses people.',
    attribution: 'Anonymous'
  }, {
    topic: 'attitude',
    category: 'lifestyle',
    content: 'Attitude is a little thing that makes a big difference.',
    attribution: 'Winston Churchill'
  }
]

quotes.each do |q|
  category = Category.find_or_create_by(title: q[:category])
  topic = Topic.find_or_create_by(title: q[:title], category: category)
  Quote.create({
    topic: q[:topic],
    category: q[:category],
    content: q[:content],
    attribution: q[:attribution]
  })
end
