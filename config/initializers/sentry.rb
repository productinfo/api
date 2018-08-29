Raven.configure do |config|
  config.dsn = Figaro.env.sentry_dsn!
  config.sanitize_fields = Rails.application.config.filter_parameters.map(&:to_s)
end
