class EditorsController < ApplicationController

  def advanced_markdown
    render :layout => false
  end

  def simple_markdown

  end

  def simple_markdown_demo

  end

  def advanced_markdown_demo
    render :layout => false
  end

  def code

  end

  def code_demo
    render "code"
  end

end
