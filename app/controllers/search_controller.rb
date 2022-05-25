class SearchController < ApplicationController

  def index
  end

  def submit
    if !params[:term].present?
      flash[:error] = "Please enter any term to search."
      redirect_to search_path and return false
    end
    begin
      @repos = SearchGithubPublicRepo.new(params[:term]).call
    rescue RestClient::RequestFailed, RestClient::Unauthorized, RestClient::RequestTimeout
      flash[:error] = "Could not find Github Repos for #{params[:term]}. Please try again later"
      redirect_to search_path and return false
    rescue => e
      flash[:error] = "There is some error while searching. Please try again."
      redirect_to search_path and return false
    end
    render template: 'search/index'
  end

end
