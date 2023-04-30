# frozen_string_literal: true

require "ruby/openai_pinecone/client"
require "webmock/rspec"

RSpec.describe Ruby::OpenaiPinecone::Client do
  let(:dummy_vector) { [1.0, 2.0, 3.0] }
  let(:dummy_id) { "test_id" }
  let(:query_text) { "test query" }
  let(:model) { "text-embedding-ada-002" }

  before do
    Ruby::OpenaiPinecone.configure do |config|
      config.openai_api_key = "fake_openai_api_key"
      config.pinecone_api_key = "fake_pinecone_api_key"
      config.pinecone_upsert_endpoint = "https://example.com/upsert"
      config.pinecone_query_endpoint = "https://example.com/query"
    end

    allow(Ruby::OpenaiPinecone::Embeddings).to receive(:generate).and_return(dummy_vector)

    stub_request(:post, "https://example.com/upsert").
      with(
        body: {
          "vectors": [{
            "id": dummy_id,
            "metadata": {},
            "values": dummy_vector
          }],
          "namespace": ""
        }.to_json
      ).
      to_return(status: 200)

    stub_request(:post, "https://example.com/query").
      with(
        body: {
          "vector": dummy_vector,
          "topK": 5,
          "includeMetadata": true,
          "includeValues": true,
          "namespace": ""
        }.to_json
      ).
      to_return(status: 200, body: { "matches": [{ "id": "1", "score": 1.0 }] }.to_json, headers: { "Content-Type" => "application/json" })
  end

  it "successfully upserts a vector to Pinecone" do
    success = Ruby::OpenaiPinecone::Client.upsert(dummy_id, dummy_vector)
    expect(success).to be(true)
  end

  it "successfully queries existing vectors in Pinecone" do
    query_result = Ruby::OpenaiPinecone::Client.query(query_text)

    expect(query_result).not_to be_nil
    expect(query_result["matches"]).to be_an(Array)
    expect(query_result["matches"].length).to be > 0
  end
end
