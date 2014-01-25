class User < ActiveRecord::Base

  validates_presence_of :phone
  validates_uniqueness_of :phone
  has_secure_password

  def send_message(quote)
    number = "+1#{self.phone.gsub('-', '')}"

    body = "\"#{quote.body}\" - #{quote.author}"

    tagline = " //Brought to you by Brad Puder//"

    @client = Twilio::REST::Client.new ENV['account_sid'], ENV['auth_token']
    
    @client.account.messages.create({
      :from => '+13125481314', 
      :to => number, 
      :body => body + tagline 
    })

  end
end