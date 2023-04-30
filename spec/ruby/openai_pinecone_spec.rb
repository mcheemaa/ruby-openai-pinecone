# frozen_string_literal: true

require "ruby/openai_pinecone"

RSpec.describe Ruby::OpenaiPinecone do
  let(:dummy_openai_api_key) { "openai_api_key" }
  let(:dummy_pinecone_api_key) { "pinecone_api_key" }
  let(:dummy_upsert_endpoint) { "https://example.com/upsert" }
  let(:dummy_query_endpoint) { "https://example.com/query" }

  before do
    Ruby::OpenaiPinecone.configure do |config|
      config.openai_api_key = dummy_openai_api_key
      config.pinecone_api_key = dummy_pinecone_api_key
      config.pinecone_upsert_endpoint = dummy_upsert_endpoint
      config.pinecone_query_endpoint = dummy_query_endpoint
    end
  end

  it "has a version number" do
    expect(Ruby::OpenaiPinecone::VERSION).not_to be nil
  end

  it "has a configuration object" do
    expect(Ruby::OpenaiPinecone.configuration).to be_a(Ruby::OpenaiPinecone::Configuration)
  end

  it "stores the OpenAI API key in the configuration" do
    expect(Ruby::OpenaiPinecone.configuration.openai_api_key).to eq(dummy_openai_api_key)
  end

  it "stores the Pinecone API key in the configuration" do
    expect(Ruby::OpenaiPinecone.configuration.pinecone_api_key).to eq(dummy_pinecone_api_key)
  end

  it "stores the Pinecone Upsert endpoint in the configuration" do
    expect(Ruby::OpenaiPinecone.configuration.pinecone_upsert_endpoint).to eq(dummy_upsert_endpoint)
  end

  it "stores the Pinecone Query endpoint in the configuration" do
    expect(Ruby::OpenaiPinecone.configuration.pinecone_query_endpoint).to eq(dummy_query_endpoint)
  end
end
