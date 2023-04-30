# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'json'

module Ruby
  module OpenaiPinecone
    class Client
      def self.upsert(id, vector, metadata: {}, namespace: "")
        uri = URI.parse(Ruby::OpenaiPinecone.configuration.pinecone_upsert_endpoint)

        request = Net::HTTP::Post.new(uri)
        request["Content-Type"] = "application/json"
        request["Api-Key"] = Ruby::OpenaiPinecone.configuration.pinecone_api_key
        request.body = {
          "vectors": [{
            "id": id,
            "metadata": metadata,
            "values": vector
          }],
          "namespace": namespace
        }.to_json

        response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
          http.request(request)
        end

        response.code == "200"
      end

      def self.query(text, topK: 5, includeMetadata: true, includeValues: true, namespace: "")
        vector = Ruby::OpenaiPinecone::Embeddings.generate(text)

        uri = URI.parse(Ruby::OpenaiPinecone.configuration.pinecone_query_endpoint)

        request = Net::HTTP::Post.new(uri)
        request["Content-Type"] = "application/json"
        request["Api-Key"] = Ruby::OpenaiPinecone.configuration.pinecone_api_key
        request.body =  {
          "vector": vector,
          "topK": topK,
          "includeMetadata": includeMetadata,
          "includeValues": includeValues,
          "namespace": namespace
        }.to_json

        response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
          http.request(request)
        end

        if response.code == "200"
          JSON.parse(response.body)
        else
          nil
        end
      end
    end
  end
end
