module Octokit
  AuthorizedClient = Client.new(
    access_token: Figaro.env.github_access_token!
  )
end
