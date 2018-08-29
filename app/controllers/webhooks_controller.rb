class WebhooksController < ApplicationController
  def github
    raise StandardError
    payload = JSON.parse(request.body.read)
    action = payload.fetch("action")
    if action == "published" && payload.key?("release")
      post_release(payload.fetch("release"))
      head :ok
    else
      head :unprocessable_entity
    end
  end

  def post_release(release)
    version = release["tag_name"]
    release_url = release["html_url"]
    Twitter::Client.update("🚀 Shipped #{version}: Find out more on the release page #{release_url}")
  end
end
