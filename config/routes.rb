Rails.application.routes.draw do

  # pro extensions
  scope path: ":user_key/:email", :constraints => { :email => /[^\/]+/ } do
    mount Revisions::Engine, at: "/revisions", constraints: ProConstraint.new

    match "/revisions" => "users#expired_pro", :via => [:get]

    get "/editors/advanced_markdown" => "editors#advanced_markdown", constraints: ProConstraint.new
    get "/editors/code" => "editors#code", constraints: ProConstraint.new
    match "/editors/*any" => "users#expired_pro", :via => [:get]
  end

  # free extensions
  mount DropboxExt::Engine, at: "/dropbox"
  mount Gdrive::Engine, at: '/gdrive'
  mount Collab::Engine, at: "/collab"
  mount ActionCable.server => "/collab/cable"

  get "editors/simple_markdown" => "editors#simple_markdown"
  get "editors/simple_markdown_demo" => "editors#simple_markdown_demo"
  get "editors/advanced_markdown_demo" => "editors#advanced_markdown_demo"
  get "editors/code_demo" => "editors#code_demo"

  scope path: "staging-demos", constraints: StagingConstraint.new do
    get "/editors/simple_markdown" => "editors#simple_markdown"
    get "/editors/advanced_markdown" => "editors#advanced_markdown"
    get "/editors/code" => "editors#code"
  end

  resources "users"
end
