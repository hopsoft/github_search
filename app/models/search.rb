require "open-uri"

class Search
  include ActiveModel::Model

  URL_TEMPLATE = "https://api.github.com/search/repositories?q={{query}}+language:{{language}}&sort=stars&order=desc"

  attr_accessor *%i[
    language
    query
  ]

  def url
    Mustache.render URL_TEMPLATE, as_json
  end

  def present?
    language.to_s.strip.present? || query.to_s.strip.present?
  end

  def perform(query: nil, language: nil)
    return [] unless present?
    results = JSON.parse(open(url).read)["items"]
    results.map { |result| Repository.new(result) }
  end
end
