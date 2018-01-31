class UsersController < ApplicationController
  def show
    @user_info = GithubService.get_user_info(current_user)
    @starred_repo_count = GithubService.get_starred_repos(current_user).count
    @followers = GithubService.get_followers(current_user)
    @followees = GithubService.get_following(current_user)
    @repos = GithubService.get_repos(current_user)
    @events = GithubService.get_events(current_user)
  end
end
