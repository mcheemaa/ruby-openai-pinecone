# frozen_string_literal: true

module Ruby
  module OpenaiPinecone
    class Configuration
      attr_accessor :openai_api_key, :pinecone_api_key, :pinecone_upsert_endpoint, :pinecone_query_endpoint

      def initialize
        @openai_api_key = nil
        @pinecone_api_key = nil
        @pinecone_upsert_endpoint = nil
        @pinecone_query_endpoint = nil
      end
    end
  end
end
