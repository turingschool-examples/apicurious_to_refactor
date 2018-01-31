class GithubService
  def self.conn(token)
    Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.adapter  Faraday.default_adapter
      faraday.params["access_token"] = token
    end
  end

  def self.get_user_info(user)
    response = conn(user.oauth_token).get "/user"
    JSON.parse(response.body)
  end

  def self.get_starred_repos(user)
    response = conn(user.oauth_token).get "/users/#{user.user_name}/starred"
    JSON.parse(response.body)
  end

  def self.get_followers(user)
    response = conn(user.oauth_token).get "/users/#{user.user_name}/followers"
    JSON.parse(response.body)
  end

  def self.get_following(user)
    response = conn(user.oauth_token).get "/users/#{user.user_name}/following"
    JSON.parse(response.body)
  end

  def self.get_repos(user)
    response = conn(user.oauth_token).get "/user/repos"
    JSON.parse(response.body)
  end

  def self.get_events(user)
    response = conn(user.oauth_token).get "/users/#{user.user_name}/events"
    raw_events = JSON.parse(response.body)
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
