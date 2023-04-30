# frozen_string_literal: true

require "ruby/openai_pinecone/version"
require "ruby/openai_pinecone/configuration"
require "ruby/openai_pinecone/embeddings"
require "ruby/openai_pinecone/client"

module Ruby
  module OpenaiPinecone
    class Error < StandardError; end

    def self.configure
      yield configuration
    end

    def self.configuration
      @configuration ||= Configuration.new
    end
  end
end
