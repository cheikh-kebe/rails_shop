
require "rest-client"
require "digest"
require 'json'
require './lib/modules/api_data'

@prk = ApiKey::PRIVATE_KEY
@puk = ApiKey::PUBLIC_KEY
number = Random.new
@time_stamp = number.rand(100)
@md5 = Digest::MD5.new
@hash = @md5.update "#{@time_stamp}#{@prk}#{@puk}"

def data_set
  api_data = {
    public: @puk,
    private: @prk,
    ts: @time_stamp,
    hash: @hash,
  }

  comics = RestClient.get("http://gateway.marvel.com/v1/public/comics?formatType=comic&noVariants=true&dateRange=2015-01-01%2C2022-01-02&limit=60&ts=#{api_data[:ts]}&apikey=#{api_data[:public]}&hash=#{api_data[:hash]}")
  
  comics_array = JSON.parse!(comics)["data"]["results"]
  
  comics_array.map do |item|
    Item.create(
      title: item["title"],
      description: item["description"].to_json,
      price: Faker::Number.decimal(l_digits: 2),
      image_url: "#{item["thumbnail"]["path"] ? item["thumbnail"]["path"] : "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available" }/portrait_uncanny.jpg"
    )
  end

end

data_set()
