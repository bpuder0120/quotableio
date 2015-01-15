class User < ActiveRecord::Base

  validates_presence_of :phone
  validates_uniqueness_of :phone
  has_secure_password

  def send_message(quote, include_tagline=true)
    number = "+1#{self.phone.gsub('-', '')}"

    if quote.respond_to? :body
      body = "\"#{quote.body}\" - #{quote.author}"
    else
      body = quote
    end

    tagline = " //Brought to you by Brad Puder//"

    @client = Twilio::REST::Client.new ENV['account_sid'], ENV['auth_token']
    message = body
    message += tagline if include_tagline
    
    @client.account.messages.create({
      :from => '+13125481314', 
      :to => number, 
      :body => message
    })

  end
end