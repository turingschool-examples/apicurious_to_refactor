class GithubService
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def conn(token)
    Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.adapter  Faraday.default_adapter
      faraday.params["access_token"] = token
    end
  end

  def get_user_info
    @info = conn(user.oauth_token).get "/user"
    parse_json(@info)
  end

  def get_starred_repos
    @repos = conn(user.oauth_token).get "/users/#{user.user_name}/starred"
    parse_json(@repos)
  end

  def get_followers
    @followers = conn(user.oauth_token).get "/users/#{user.user_name}/followers"
    parse_json(@followers)
  end

  def get_following
    @following = conn(user.oauth_token).get "/users/#{user.user_name}/following"
    parse_json(@following)
  end

  def get_repos
    @user_repos = conn(user.oauth_token).get "/user/repos"
    parse_json(@user_repos)
  end

  def get_events
    @events = conn(user.oauth_token).get "/users/#{user.user_name}/events"
    raw_events = parse_json(@events)
    raw_events.map do |raw_event|
      {
        type: raw_event["type"].gsub(/[a-z][A-Z]/) do |match|
          "#{match[0]} #{match[1]}"
        end,
        created_at: Time.parse(raw_event["created_at"]),
        repo: raw_event["repo"]
      }
    end
  end
end

private

  def parse_json(response)
    JSON.parse(response.body)
  end
