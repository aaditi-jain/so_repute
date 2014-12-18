require 'spec_helper'
require 'httparty'

describe SoRepute do
	before (:all) do  	   	
    @user = SoRepute::Base.new(2440312, "BgnaQ2fdzYqqWRX1RQvxog((")
    @required_user_info = HTTParty.get("http://api.stackexchange.com/users/2440312/?site=stackoverflow&key=BgnaQ2fdzYqqWRX1RQvxog((").parsed_response["items"][0]
    @required_user_answers = HTTParty.get("http://api.stackexchange.com/users/2440312/answers/?site=stackoverflow&filter=!9YdnSQVoS&pagesize=100&page=1&key=BgnaQ2fdzYqqWRX1RQvxog((").parsed_response
    @required_user_answers = HTTParty.get("http://api.stackexchange.com/users/2440312/questions/?site=stackoverflow&filter=!9YdnSQVoS&pagesize=100&page=1&key=BgnaQ2fdzYqqWRX1RQvxog((").parsed_response
  end

  describe '#reputation' do 
    it 'should output users total reputation' do
      @user.reputation.should eq(@required_user_info["reputation"])
    end 	
  end

  describe '#reputation_change_quarter'do
    it 'should output users reputation gained in the current quarter' do
      @user.reputation_change_quarter.should eq(@required_user_info["reputation_change_quarter"])
    end
  end

  describe '#reputation_change_month'do
    it 'should output users reputation gained in the current month' do
      @user.reputation_change_month.should eq(@required_user_info["reputation_change_month"])
    end
  end

  describe '#reputation_change_week'do
    it 'should output users reputation gained in the current week' do
      @user.reputation_change_week.should eq(@required_user_info["reputation_change_week"])
    end
  end


  describe '#reputation_change_day'do
    it 'should output users reputation gained in the day(UTC)' do
      @user.reputation_change_day.should eq(@required_user_info["reputation_change_day"])
    end
  end

  describe '#badges'do
    it 'should output a hash with counts of different badges' do
      @user.badges.should eq({bronze: @required_user_info["badge_counts"]["bronze"],
      												silver: @required_user_info["badge_counts"]["silver"],
      												gold: @required_user_info["badge_counts"]["gold"],
      												total: (@required_user_info["badge_counts"]["bronze"] + @required_user_info["badge_counts"]["silver"] + @required_user_info["badge_counts"]["gold"] )
      	                     })
    end
  end
end