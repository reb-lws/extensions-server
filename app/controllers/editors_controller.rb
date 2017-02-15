class EditorsController < ApplicationController


  def advanced_markdown

    render :layout => false
  end

  def simple_markdown
    render :layout => false
  end

end
