# frozen_string_literal: true

require_relative "laftel/version"
require 'httparty'

module Laftel
  @base_url = 'https://laftel.net/api'

  class Error < StandardError; end

  extend self

  def search(keyword = '')
    uri = @base_url + '/search/v1/keyword'

    if keyword.class.name != 'String'
      return { success: false, message: 'keyword의 타입이 일치하지 않아요.' }
    end
    if keyword.length < 1
      return { success: false, message: 'keyword가 형식에 맞지 않아요.' }
    end

    res = HTTParty.get(uri, :query => { 'keyword': keyword }, :headers => { 'laftel': 'TeJava' })
    return { success: true, result: JSON.parse(res.body) }
  end

  def get_item(id = '')
    uri = @base_url + '/v1.0/items/'

    if id.class.name != 'String'
      return { success: false, message: 'id의 타입이 일치하지 않아요.' }
    end
    if id.length < 1
      return { success: false, message: 'id가 형식에 맞지 않아요.' }
    end

    res = HTTParty.get(uri + id + '/detail', :headers => { 'laftel': 'TeJava' })
    return { success: true, result: JSON.parse(res.body) }
  end

  def get_episode(id = '')
    uri = @base_url + '/episodes/v1/list'

    if id.class.name != 'String'
      return { success: false, message: 'id의 타입이 일치하지 않아요.' }
    end
    if id.length < 1
      return { success: false, message: 'id가 형식에 맞지 않아요.' }
    end

    res = HTTParty.get(uri, :query => { 'item_id': id }, :headers => { 'laftel': 'TeJava' })
    puts res.body
    # return { success: true, result: JSON.parse(res.body) }
  end
end