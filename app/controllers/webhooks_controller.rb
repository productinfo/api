class WebhooksController < ApplicationController
  def github
    request.body.rewind
    payload_body = request.body.read
    verify_signature(payload_body)

    payload = JSON.parse(payload_body)
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

  # https://developer.github.com/webhooks/securing/
  def verify_signature(payload_body)
    signature = 'sha1=' + OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha1'), Figaro.env.github_secret_token!, payload_body)
    return halt 500, "Signatures didn't match!" unless Rack::Utils.secure_compare(signature, request.env['HTTP_X_HUB_SIGNATURE'])
  end

end
