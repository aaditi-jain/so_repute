# SoRepute 

  Fetches StackOverflow information of a person from his/her stackoverflow user_id

## Installation

  ** It is advisable to register your application in at stackapps when using this gem (which inturn uses stackexchange API). Use this link to register your application at stackapps https://stackapps.com/apps/oauth/register**

Add this line to your application's Gemfile:
  `gem 'so_repute'`

And then execute:
  `$ bundle`

Or install it yourself as:
  `$ gem install so_repute`

## Usage

  **require 'so_repute'**

  **user = SoRepute::Base.new(user_id, app_key)**
  #app_key is obtained when you register your app at stackapps. Registering your app alows you a larger number of hit-quota per day. If you do not want to register your app, do : oRepute::Base.new(user_id)

  1) **user.reputation**

  #returns current total reputation of the user.

  2) **user.reputation_change_quarter**

  #returns users reputation gained in the current quarter

  3) **user.reputation_change_month**

  #returns users reputation gained in the current month


  4) **user.reputation_change_week**

  #returns users reputation gained in the current week
  

  5) **user.reputation_change_day**

  #returns users reputation gained today(UTC) 
  
  6) **user.badges**

  #Returns a array with count of each type of badge as well as total number of badges of a user in a format as follows: {bronze: 12, silver: 4, gold: 4, total: 20}
  

  7) **user.total_answers**

  #returns total number of answers answered by a user.
  
    
  8) **user.total_questions**

  #returns total number of questions asked by a user.
  
  
  9) **user.accepted_answers**

  #returns totalnumber of answers by the user that were accepted as correct answer.
  

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
