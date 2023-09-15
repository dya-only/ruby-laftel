# frozen_string_literal: true

require_relative "laftel/version"
require 'httparty'

module Laftel
  @base_url = 'https://laftel.net/api'

  class Error < StandardError; end

  extend self

  def search(keyword = '')
    uri = @base_url + '/search/v3/keyword'

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
    uri = @base_url + '/items/v2/'

    if id.class.name != 'String'
      return { success: false, message: 'id의 타입이 일치하지 않아요.' }
    end
    if id.length < 1
      return { success: false, message: 'id가 형식에 맞지 않아요.' }
    end

    res = HTTParty.get(uri + id, :headers => { 'laftel': 'TeJava' })
    return { success: true, result: JSON.parse(res.body) }
  end

  def get_episode(id = '')
    uri = @base_url + '/episodes/v2/list'

    if id.class.name != 'String'
      return { success: false, message: 'id의 타입이 일치하지 않아요.' }
    end
    if id.length < 1
      return { success: false, message: 'id가 형식에 맞지 않아요.' }
    end

    res = HTTParty.get(uri, :query => { 'item_id': id }, :headers => { 'laftel': 'TeJava' })
    return { success: true, result: JSON.parse(res.body) }
  end

  def discover
    uri = @base_url + '/search/v1/discover'

    res = HTTParty.get(uri, :query => { 'sort': 'rank', 'offset': 0, 'size': 60 })
    return { success: true, result: JSON.parse(res.body) }
  end

  def auto_complete(keyword = '')
    uri = @base_url + '/search/v1/auto_complete'

    if keyword.class.name != 'String'
      return { success: false, message: 'keyword의 타입이 일치하지 않아요.' }
    end
    if keyword.length < 1
      return { success: false, message: 'keyword가 형식에 맞지 않아요.' }
    end

    res = HTTParty.get(uri, :query => { 'keyword': keyword }, :headers => { 'laftel': 'TeJava' })
    return { success: true, result: JSON.parse(res.body) }
  end

  def ranking(type = '')  # 4hour, week, quarter, history
    uri = @base_url + '/home/v1/recommend/ranking'

    res = HTTParty.get(uri, :query => { 'type': type }, :headers => { 'laftel': 'TeJava' })
    return { success: true, result: JSON.parse(res.body) }
  end

  def hot
    uri = @base_url + '/items/v1/hot'

    res = HTTParty.get(uri, :headers => { 'laftel': 'TeJava' })
    return { success: true, return: JSON.parse(res.body) }
  end

  def daily
    uri = @base_url + '/search/v2/daily'

    res = HTTParty.get(uri, :headers => { 'laftel': 'TeJava' })
    return { success: true, return: JSON.parse(res.body) }
  end

  def carousels
    uri = @base_url + '/carousels/v1/list'

    res = HTTParty.get(uri, :headers => { 'laftel': 'TeJava' })
    return { success: true, return: JSON.parse(res.body) }
  end
end