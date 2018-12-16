class WebhooksController < ApplicationController
  def github
    request.body.rewind
    payload_body = request.body.read
    verify_signature(payload_body)

    payload = JSON.parse(payload_body)

    unless payload.key?("action")
      head :unprocessable_entity
      return
    end

    action = payload.fetch("action")
    head :ok
  end

  # https://developer.github.com/webhooks/securing/
  def verify_signature(payload_body)
    signature = 'sha1=' + OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha1'), Figaro.env.github_secret_token!, payload_body)
    return halt 500, "Signatures didn't match!" unless Rack::Utils.secure_compare(signature, request.env['HTTP_X_HUB_SIGNATURE'])
  end

end
