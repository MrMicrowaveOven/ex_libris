PAGE_SIZE = 100
class Import < ApplicationRecord
  before_create :create_books
  
  private
  
  def create_books
    client = Goodreads::Client.new(
      api_key: ENV.fetch("GOODREADS_KEY"), 
      api_secret: ENV.fetch("GOODREADS_KEY")
    )
    
    (client.shelf(6331420, shelf, per_page: PAGE_SIZE).total / PAGE_SIZE).ceil.times do |page|
      client.shelf(6331420, shelf, per_page: PAGE_SIZE, page: page).books.each do |wrapper|
        Book.create! title: wrapper.book.title, isbn: wrapper.book.isbn
      end
    end

  end
end
