require "so_repute/version"
require 'httparty'
module SoRepute
  class Base
  	def initialize(user_id, app_key=nil)
      user_info = HTTParty.get("https://api.stackexchange.com/users/#{user_id.to_s}/?site=stackoverflow" + (app_key.nil? ? "" : "&key=#{app_key}")).parsed_response
      if user_info.keys.include?("error_id")
      	raise "Incorrect user_id or app_key"
      else
      	@user_info = user_info["items"][0]
      	@user_answers = HTTParty.get("https://api.stackexchange.com/users/#{user_id.to_s}/answers/?site=stackoverflow&pagesize=100&filter=!9YdnSQVoS" + (app_key.nil? ? "" : "&key=#{app_key}")).parsed_response
      	@user_questions = user_questions = HTTParty.get("https://api.stackexchange.com/users/#{user_id.to_s}/questions/?site=stackoverflow" + (app_key.nil? ? "" : "&key=#{app_key}")).parsed_response
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
     {bronze: bronze, silver: silver, gold: gold }      
    end
    
    def total_answers
      total = @user_answers[:total]
    end 
  end
end
