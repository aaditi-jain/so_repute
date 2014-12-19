require "so_repute/version"
require 'httparty'
require 'nokogiri'
require 'open-uri'
module SoRepute
  class Base
  	def initialize(user_id, app_key=nil)
      @user_id = user_id
      @app_key = app_key
      user_info = HTTParty.get("https://api.stackexchange.com/users/#{@user_id}/?site=stackoverflow&key=#{@app_key}").parsed_response      
      if user_info.keys.include?("error_id")
      	raise ((user_info["error_name"] == "throttle_violation") ? "Number Of Requests exceeded the daily quota of #{@app_key.nil? ? 300 : 10000}" : "Incorrect user_id or app_key")
      else
      	@user_info = user_info["items"][0]      
      end
  	end

  	def reputation
  	  @user_info["reputation"]
  	end

  	def reputation_change_quarter
  	  @user_info["reputation_change_quarter"]
  	end

    def reputation_change_month
  	  @user_info["reputation_change_month"]
  	end

    def reputation_change_week
  	  @user_info["reputation_change_week"]
  	end

  	def reputation_change_day
  	  @user_info["reputation_change_day"]
  	end

    def badges
      bronze = @user_info["badge_counts"]["bronze"]
      silver =  @user_info["badge_counts"]["silver"]
      gold = @user_info["badge_counts"]["gold"]
      total = bronze + silver + gold
      {bronze: bronze, silver: silver,  gold: gold, total: total }      
    end
    
    def total_answers
      user_answers = HTTParty.get("https://api.stackexchange.com/users/#{@user_id}/answers/?site=stackoverflow&pagesize=100&filter=!9YdnSQVoS&page=1" + (@app_key.nil? ? "" : "&key=#{@app_key}")).parsed_response      
      if user_answers.keys.include?("error_id")
        raise ((user_answers["error_name"] == "throttle_violation") ? "Number Of Requests exceeded the daily quota of #{@app_key.nil? ? 300 : 10000}" : "Error occured while fetching data. ")
      else
        user_answers["total"]   
      end      
    end 

    def accepted_answers   
      search_page = Nokogiri::HTML(open("https://stackoverflow.com/search?q=user%3A#{@user_id}+isaccepted%3Ayes"))  
      search_page.css('div.results-header > h2').first.text.delete(",results").strip.to_i
    end

    def total_questions
      user_questions = HTTParty.get("https://api.stackexchange.com/users/#{@user_id}/questions/?site=stackoverflow&filter=!9YdnSQVoS&pagesize=100&page=1" + (@app_key.nil? ? "" : "&key=#{@app_key}")).parsed_response
      if user_questions.keys.include?("error_id")
        raise ((user_questions["error_name"] == "throttle_violation") ? "Number Of Requests exceeded the daily quota of #{@app_key.nil? ? 300 : 10000}" : "Error occured while fetching data")
      else
        user_questions["total"]   
      end   
    end

  end
end
