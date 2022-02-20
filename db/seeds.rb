
require "rest-client"
require "digest"
require 'json'

Public_key = ENV["MARVEL_PUBLIC_API_KEY"]
Private_key = ENV["MARVEL_PRIVATE_API_KEY"]
number = Random.new
@time_stamp = number.rand(100)
@md5 = Digest::MD5.new
@hash = @md5.update "#{@time_stamp}#{Private_key}#{Public_key}"

def data_set
  api_data = {
    public: Public_key,
    private: Private_key,
    ts: @time_stamp,
    hash: @hash,
  }

  series = RestClient.get("http://gateway.marvel.com/v1/public/series?ts=#{api_data[:ts]}&apikey=#{api_data[:public]}&hash=#{api_data[:hash]}")
  series_array = JSON.parse(series)["data"]["results"]

  comics = RestClient.get("http://gateway.marvel.com/v1/public/comics?ts=#{api_data[:ts]}&apikey=#{api_data[:public]}&hash=#{api_data[:hash]}")
  comics_array = JSON.parse(comics)["data"]["results"]

  series_array.map do |item|
    Item.create!(
      title: item["title"],
      description: Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4),
      price: Faker::Number.decimal(l_digits: 2),
      image_url: "#{item["thumbnail"]["path"] ? item["thumbnail"]["path"] : "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available" }/portrait_uncanny.jpg"
    )
  end
  comics_array.map do |item|
    Item.create!(
      title: item["title"],
      description: Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4),
      price: Faker::Number.decimal(l_digits: 2),
      image_url: "#{item["thumbnail"]["path"] ? item["thumbnail"]["path"] : "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available" }/portrait_uncanny.jpg"
    )
  end
  # variants = RestClient.get("http://gateway.marvel.com/v1/public/comics?ts=#{api_data[:ts]}&apikey=#{api_data[:public]}&hash=#{api_data[:hash]}")
  # variants_array = JSON.parse(variants)["data"]["results"]["variants"]


end

data_set()

# 20.times do
#   item = Item.create!(
#     title: Faker::Creature::Cat.breed,
#     description: Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4),
#     price: Faker::Number.decimal(l_digits: 2),
#   )
# end
