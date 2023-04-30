# frozen_string_literal: true

require 'openai'

module Ruby
  module OpenaiPinecone
    class Embeddings
      def self.generate(text, model: "text-embedding-ada-002")
        client = ::OpenAI::Client.new(
          access_token: Ruby::OpenaiPinecone.configuration.openai_api_key,
        )

        response = client.embeddings(
          parameters: {
            input: text,
            model: model
          }
        )

        response["data"][0]["embedding"]
      end
    end
  end
end
