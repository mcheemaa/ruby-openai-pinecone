# frozen_string_literal: true
require 'ruby/openai_pinecone'

# Configure the gem with your credentials
Ruby::OpenaiPinecone.configure do |config|
  config.openai_api_key = ""
  config.pinecone_api_key = ""
  config.pinecone_upsert_endpoint = ""
  config.pinecone_query_endpoint = ""
end

# Generate a vector for the input text
text = "Uber Eats is an American online food ordering and delivery platform launched by Uber in 2014 and based in San Francisco, California. Users can read menus, reviews and ratings, order food from participating restaurants, and pay for their orders with Uber Eats."
vector = Ruby::OpenaiPinecone::Embeddings.generate(text)
puts "Generated vector: #{vector}"

# Upsert the vector to Pinecone
# id = "7"
# success = Ruby::OpenaiPinecone::Client.upsert(id, vector)
# puts "Upsert successful" if success

# Query the existing vectors
query_result = Ruby::OpenaiPinecone::Client.query(text)
ids_and_scores = query_result["matches"].map { |match| { id: match["id"], score: match["score"] } }
puts "Query result: #{ids_and_scores}"
