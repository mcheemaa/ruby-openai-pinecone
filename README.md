# Ruby Pinecone

A Ruby gem for semantic search using Pinecone and OpenAI API. This gem provides out-of-the-box functionality for generating vectors using the OpenAI API's text-embedding-ada-002 model and uploading them to Pinecone for efficient semantic search. It also includes features for querying existing vectors and retrieving relevant metadata. With this gem, developers can easily incorporate semantic search capabilities into their Ruby applications without needing to worry about the underlying implementation details.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add ruby-openai-pinecone

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install ruby-openai-pinecone

## Usage

You can find instructions here - `ruby-openai-pinecone/examples/test.rb`

## Example Use Case: Semantic Book Recommendation Engine

Let's say we want to create a simple book recommendation engine using the Ruby OpenAI Pinecone gem. We'll start by creating vectors for a few books, then query the engine to get recommendations based on a user's interests.

Before you begin, make sure to set up your Pinecone and OpenAI API configurations. Example in `examples/test.rb`

1. First, create some book data:

```ruby
books = [
  {
    id: "book_1",
    title: "The Catcher in the Rye",
    description: "The story of teenage angst and self-discovery, narrated by the protagonist Holden Caulfield. The book delves into themes of identity, belonging, and the painful process of growing up.",
  },
  {
    id: "book_2",
    title: "To Kill a Mockingbird",
    description: "A novel about racial inequality and moral growth, set in the American South during the 1930s. Through the eyes of young Scout Finch, the reader witnesses the struggle for justice in a divided community.",
  },
  {
    id: "book_3",
    title: "1984",
    description: "A dystopian novel exploring the dangers of totalitarianism, surveillance, and loss of individuality. Set in the grim world of Airstrip One, the story follows Winston Smith as he tries to break free from the control of Big Brother.",
  },
  {
    id: "book_4",
    title: "Pride and Prejudice",
    description: "A romantic novel that follows the emotional development of protagonist Elizabeth Bennet and her suitor, Mr. Darcy. Set in early 19th-century England, the story explores themes of love, marriage, and social expectations.",
  },
  {
    id: "book_5",
    title: "Moby Dick",
    description: "A tale of obsession and revenge, as Captain Ahab hunts the elusive white whale, Moby Dick. The novel explores themes of fate, free will, and the struggle between good and evil.",
  }
]
```

2. Generate vectors for each book title and description, then upsert them to Pinecone:

```ruby
books.each do |book|
  text = "#{book[:title]}: #{book[:description]}"
  vector = Ruby::OpenaiPinecone::Embeddings.generate(text)
  Ruby::OpenaiPinecone::Client.upsert(book[:id], vector)
end
```

3. Query the recommendation engine based on a user's interests:

```ruby
user_interest = "I'm looking for a book about personal growth and the fight against injustice."

results = Ruby::OpenaiPinecone::Client.query(user_interest)
```

4. Show the top recommended books:

```ruby
puts "Recommended books:"
results["matches"].each_with_index do |match, index|
  book = books.find { |b| b[:id] == match["id"] }
  puts "#{index + 1}. #{book[:title]} (Score: #{match["score"]})"
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mcheemaa/ruby-openai-pinecone. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/mcheemaa/ruby-openai-pinecone/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Ruby::Pinecone project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/mcheemaa/ruby-openai-pinecone/blob/master/CODE_OF_CONDUCT.md).
