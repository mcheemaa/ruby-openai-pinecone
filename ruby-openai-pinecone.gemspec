# frozen_string_literal: true

require_relative "lib/ruby/openai_pinecone/version"

Gem::Specification.new do |spec|
  spec.name = "ruby-openai-pinecone"
  spec.version = Ruby::OpenaiPinecone::VERSION
  spec.authors = ["Muhammad Ahmed Cheema"]
  spec.email = ["mcheema@fandm.edu"]

  spec.summary = "A Ruby gem for semantic search using Pinecone and OpenAI API."
  spec.description = "This gem provides out-of-the-box functionality for generating vectors using the OpenAI API's text-embedding-ada-002 model and uploading them to Pinecone for efficient semantic search. It also includes features for querying existing vectors and retrieving relevant metadata. With this gem, developers can easily incorporate semantic search capabilities into their Ruby applications without needing to worry about the underlying implementation details."
  spec.homepage = "https://github.com/mcheemaa/ruby-openai-pinecone"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/mcheemaa/ruby-openai-pinecone"
  spec.metadata["changelog_uri"] = "https://github.com/mcheemaa/ruby-openai-pinecone/blob/master/CHANGELOG.md"

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Dependencies
  spec.add_dependency "ruby-openai", "~> 3.7.0"
end
