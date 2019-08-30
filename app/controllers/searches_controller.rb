class SearchesController < ApplicationController
  def index
    @search = Search.new(JSON.parse(cookies[:search] || "{}"))
    @results = @search.perform
  end

  def create
    cookies[:search] = Search.new(search_params).to_json
    redirect_to searches_path
  end

  private

  def search_params
    params.require(:search).permit(:language, :query)
  end
end
