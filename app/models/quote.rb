class Quote < ActiveRecord::Base

  validates_presence_of :body

  def self.fetch
    categories = ["inspire", "love", "management", "life", "sports"]
    
    categories.each do |category|
      response = HTTParty.get("http://api.theysaidso.com/qod?category=#{category}")
      Quote.create(body: response['contents']['quote'], author: response['contents']['author'], category: category)
    end
  end

  def self.find_users
    Quote.all.last(5).each do |quote|
      users = User.where(category: quote.category)
      users.each do |user|
        user.send_message(quote)
      end
    end
  end


end