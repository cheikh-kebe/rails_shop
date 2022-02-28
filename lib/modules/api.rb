module Api
  require "rest-client"
  require "digest"
  require "json"
  
  Public_key = Rails.application.credentials.marvel[:marvel_public_api_key]
  Private_key = Rails.application.credentials.marvel[:marvel_private_api_key]
  number = Random.new
  Time_stamp = number.rand(100)
  Md5 = Digest::MD5.new
  Hash = Md5.update "#{Time_stamp}#{Private_key}#{Public_key}"

  def data_set
    api_data = {
      public: Public_key,
      private: Private_key,
      ts: Time_stamp,
      hash: Hash,
    }
  end

  def series
    res = RestClient.get("http://gateway.marvel.com/v1/public/series?ts=#{api_data[:ts]}&apikey=#{api_data[:public]}&hash=#{api_data[:hash]}")
    puts res.headers[:content_type]
  end
end
