require 'net/http'
require 'uri'
require 'json'

class WatersController < ApplicationController

  def index
    
  end
  
  def search
    @results = []
    if params[:keyword]
      keyword = URI.encode(params[:keyword])
      uri = URI.parse('https://www.livlog.xyz/springwater/springWater?q=' + keyword)
      json = Net::HTTP.get(uri)
      result = JSON.parse(json)
      result_tmp = result["data"]
      result_tmp.each do |data|
        hash = data.keep_if {|key| key == "access" || key == "address" || key == "furigana" || key == "latitude" || key == "longitude" || key == "name" || key == "overview"}
        @results << hash
      end
      Waterinfo.delete_all
      @results.each do |data|
        if data["name"].present?
          name = data["name"]
        else
          name = "なし"
        end
        if data["furigana"].present?
          furigana = "【#{data["furigana"]}】"
        else
          furigana = ""
        end
        imgurl = "https://map.yahooapis.jp/map/V1/static?appid=dj00aiZpPUJUbU9jQTI1MVVoSiZzPWNvbnN1bWVyc2VjcmV0Jng9Mjc-&pin=#{data["latitude"]},#{data["longitude"]}&z=15&width=200&height=200"
        mapurl = "http://maps.google.com/maps?q=#{data["latitude"]},#{data["longitude"]}"
        Waterinfo.create(name: name,furigana: furigana,access: "#{data["access"]}",address: "#{data["address"]}",overview: "#{data["overview"]}",imgurl: imgurl,mapurl: mapurl)
      end
      @info =Waterinfo.page(params[:page]).per(10).order("address")
    end
  end
end
