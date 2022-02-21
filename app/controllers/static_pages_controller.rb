class StaticPagesController < ApplicationController
  require "rest-client"
  require "digest"
  require "json"
  require "./lib/modules/api_data"

  def home
    @items = Item.all
    @prk = ApiKey::PRIVATE_KEY
    @puk = ApiKey::PUBLIC_KEY
    number = Random.new
    @time_stamp = number.rand(100)
    @md5 = Digest::MD5.new
    @hash = @md5.update "#{@time_stamp}#{@prk}#{@puk}"

    api_data = {
      public: @puk,
      private: @prk,
      ts: @time_stamp,
      hash: @hash,
    }
    url = "http://gateway.marvel.com/v1/public/"
    iron_man = RestClient.get("#{url}characters?name=iron%20man&ts=#{api_data[:ts]}&apikey=#{api_data[:public]}&hash=#{api_data[:hash]}")
    iron_man_thumb = JSON.parse(iron_man)["data"]["results"]
    @attribution_url = JSON.parse(iron_man)["attributionText"]

    iron_man_thumb.map do |im|
      @iron_man_image = "#{im["thumbnail"]["path"]}/portrait_uncanny.jpg"
      @iron_man_name = im["name"]
      @iron_man_description = im["description"]
    end

    hulk = RestClient.get("#{url}characters?name=hulk&ts=#{api_data[:ts]}&apikey=#{api_data[:public]}&hash=#{api_data[:hash]}")
    hulk_thumb = JSON.parse(hulk)["data"]["results"]

    hulk_thumb.map do |im|
      @hulk_image = "#{im["thumbnail"]["path"]}/portrait_uncanny.jpg"
      @hulk_name = im["name"]
      @hulk_description = im["description"]
    end
    
    thor = RestClient.get("#{url}characters?name=thor&ts=#{api_data[:ts]}&apikey=#{api_data[:public]}&hash=#{api_data[:hash]}")
    thor_thumb = JSON.parse(thor)["data"]["results"]

    thor_thumb.map do |im|
      @thor_image = "#{im["thumbnail"]["path"]}/portrait_uncanny.jpg"
      @thor_name = im["name"]
      @thor_description = im["description"]
    end

    
  end
end
