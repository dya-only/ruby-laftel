# frozen_string_literal: true

require_relative "laftel/version"
require 'httparty'

module Laftel
  @base_url = 'https://laftel.net/api'

  class Error < StandardError; end

  extend self
  def search(keyword)
    uri = @base_url + '/search/v1/keyword'

    res = HTTParty.get(uri, :query => { 'keyword': keyword }, :headers => { 'laftel': 'TeJava' })
    puts JSON.parse(res.body)
  end
end