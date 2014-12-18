require "so_repute/version"
require 'httparty'
module SoRepute
  class Base
  	def initialize(user_id, app_key=nil)
      @user_id = user_id
      @app_key = app_key
      user_info = HTTParty.get("http://api.stackexchange.com/users/#{@user_id}/?site=stackoverflow" + (@app_key.nil? ? "" : "&key=#{@app_key}")).parsed_response      
      if user_info.keys.include?("error_id")
      	raise "Incorrect user_id or app_key"
      else
      	@user_info = user_info["items"][0]
      	@user_answers = HTTParty.get("http://api.stackexchange.com/users/#{@user_id}/answers/?site=stackoverflow&pagesize=100&filter=!9YdnSQVoS&page=1" + (@app_key.nil? ? "" : "&key=#{@app_key}")).parsed_response
      	@user_questions = user_questions = HTTParty.get("http://api.stackexchange.com/users/#{@user_id}/questions/?site=stackoverflow&filter=!9YdnSQVoS&pagesize=100&page=1" + (@app_key.nil? ? "" : "&key=#{@app_key}")).parsed_response
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
      @user_answers[:total]
    end 

    def accepted_answers  
      i = 1
      user_answers = @user_answers
      until (user_answers["has_more"] == false and i != 1) do
        accepted_answers+= count_accepted_answers(user_answers)
        i +=1
        user_answers =  HTTParty.get("https://api.stackexchange.com/users/#{@user_id}/answers/?site=stackoverflow&pagesize=100&filter=!9YdnSQVoS&page=#{i}" + (@app_key.nil? ? "" : "&key=#{@app_key}")).parsed_response              
      end     
      accepted_answers       
    end

    def total_questions
      @user_questions[:total]
    end


    private
      def count_accepted_answers(user_answers)
        accepted_answers = 0
        user_answers["items"].each{|ans| accepted_answers += 1 if (ans["is_accepted"] == true)}
        accepted_answers
      end

  end
end
