class Book < ApplicationRecord
  include Rails.application.routes.url_helpers
  validates :title, presence: true
  
  def qr
    URI::HTTP.build(
      host:'api.qrserver.com',
      path: '/v1/create-qr-code',
      query: {
        data: book_url(self),
        size: "100x100"
      }.to_query
    ).to_s
  end
end
