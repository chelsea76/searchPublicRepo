class SearchGithubPublicRepo

  attr_accessor :term

  def initialize(term)
    @term = term
  end

  def call
    page = 1
    url = host + "search/repositories?q=#{term}&page=#{page}&per_page=100"
    repos = []
    while true
      response = RestClient.get(url, headers)
      result = JSON.parse(response.body)
      total_pages = result['total_count'] / 100
      repos << result['items'].map {|repo| { name: repo['name'], url: repo['html_url']}}
      return if page > total_pages
      page += 1
    end
    repos.flatten
  end

  def headers
    {
      'Authorization' => "token #{ENV['GITHUB_PERSONAL_TOKEN']}",
    }
  end

  def host
    'https://api.github.com/'
  end

end

