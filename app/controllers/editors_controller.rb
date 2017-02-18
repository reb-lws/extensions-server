class EditorsController < ApplicationController

  skip_after_action :allow_iframe, :only => [:advanced_markdown_demo]

  def advanced_markdown
    render :layout => false
  end

  def simple_markdown
    # render :layout => false
  end

  def advanced_markdown_demo
    referer = request.headers['HTTP_REFERER']
    uri = URI.parse(referer)
    url = "#{uri.scheme}://#{uri.host}" + (uri.port ? ":#{uri.port}" : "")

    if url == ENV['WEBSITE_HOST']
      response.headers.except! 'X-Frame-Options'
    else
      response.headers["X-FRAME-OPTIONS"] = "DENY"
    end

    render :layout => false
  end

end
