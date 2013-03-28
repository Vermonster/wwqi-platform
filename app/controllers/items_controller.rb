class ItemsController < ApplicationController
  respond_to :json

  def search
    @results = HTTParty.get(SEARCH_URL+'/'+SEARCH_INDEX+'/_search?q=title_en:tin')
    respond_with(@results)
  end
end
