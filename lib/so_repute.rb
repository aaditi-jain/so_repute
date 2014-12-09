require "so_repute/version"
require 'httparty'
module SoRepute
  class Base
  	def initialize(user_id, app_key=nil)
   	  url =  "https://api.stackexchange.com/users/#{user_id.to_s}/?site=stackoverflow" + (app_key.nil? ? "" : "&key=#{app_key}")      
      user = HTTParty.get(url).parsed_response
      if user.keys.include?("error_id")
      	raise "Incorrect user_id or app_key"
      else
      	@user_info = user["items"][0]
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
    
    def 
  end
end
