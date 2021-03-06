
require "rest-client"
require "digest"
require 'json'

@prk = ENV['MARVEL_PRIVATE_API_KEY']
@puk = ENV['MARVEL_PUBLIC_API_KEY']
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
    Item.create!(
      title: item["title"],
      description: item["description"].to_json,
      price: 15.00,
      image_url: "#{item["thumbnail"]["path"] ? item["thumbnail"]["path"] : "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available" }/portrait_uncanny.jpg",
      item_format: item["format"]
    )
  end

end

data_set()
