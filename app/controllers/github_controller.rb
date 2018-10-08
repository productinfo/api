class GithubController < ApplicationController
  ORGANIZATION = "tuist"

  def contributors
    team_id = Figaro.env.github_contributors_team_id!.to_i
    github_response = Octokit::AuthorizedClient.team_members(team_id)
    render json: github_response.map(&:to_hash)
  end

  def projects
    github_response = Octokit::AuthorizedClient.organization_repositories(ORGANIZATION)
    render json: github_response.map(&:to_hash)
  end
end
