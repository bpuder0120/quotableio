class User < ActiveRecord::Base

  validates_presence_of :phone
  validates_uniqueness_of :phone
  has_secure_password

  def get_quote
    category = self.category
    if category == "business"
      category = "management"
    elsif category == "inspiration"
      category = "inspire"
    end
    HTTParty.get("http://api.theysaidso.com/qod?category=#{category}")
  end

  def send_message
    response = self.get_quote["contents"]
    number = "+1#{self.phone.gsub('-', '')}"

    body = "\"#{response['quote']}\"\t- #{response['author']}\n/Brought to you by Quotable.io/" 

    account_sid = 'AC10d2628fdf4415d5df94911684ec4610' 
    auth_token = '92d7f0a61edef00438529e12edd8eb0c' 

    @client = Twilio::REST::Client.new account_sid, auth_token

    @client.account.messages.create({
      :from => '+17879190827', 
      :to => number, 
      :body => "\"#{response['quote']}\"\t- #{response['author']}\n/Brought to you by Quotable.io/" 
    })

  end
end