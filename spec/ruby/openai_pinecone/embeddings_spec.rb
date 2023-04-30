# frozen_string_literal: true

require "ruby/openai_pinecone/embeddings"
require "webmock/rspec"

RSpec.describe Ruby::OpenaiPinecone::Embeddings do
  let(:dummy_text) { "This is a test text." }
  let(:mocked_embedding) { [1.0, 2.0, 3.0] }
  let(:model) { "text-embedding-ada-002" }

  before do
    Ruby::OpenaiPinecone.configure do |config|
      config.openai_api_key = "fake_openai_api_key"
    end
    stub_request(:post, "https://api.openai.com/v1/embeddings").
      with(body: { "input": dummy_text, "model": model }).
      to_return(status: 200, body: { "data": [{ "embedding": mocked_embedding }] }.to_json, headers: { "Content-Type" => "application/json" })
  end

  it "generates an embedding for the given text" do
    vector = Ruby::OpenaiPinecone::Embeddings.generate(dummy_text)
    expect(vector).to eq(mocked_embedding)
  end
end
