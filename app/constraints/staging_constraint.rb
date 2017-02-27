class StagingConstraint

  def initialize

  end

  def matches?(request)
    Rails.logger.info("Matches? #{request.inspect}")

    origin = URI.parse(request.headers['HTTP_REFERER'])
    allowed = URI.parse(ENV['STAGING_APP_ORIGIN'])
    return origin.host == allowed.host && origin.port == allowed.port
  end
end
