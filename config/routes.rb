Rails.application.routes.draw do

  # pro extensions
  scope path: ":user_key/:email", :constraints => { :email => /[^\/]+/ } do
    mount Revisions::Engine, at: "/revisions", constraints: ProConstraint.new

    match "/revisions" => "users#expired_pro", :via => [:get]

    get "/editors/advanced_markdown" => "editors#advanced_markdown", constraints: ProConstraint.new
    match "/editors/*any" => "users#expired_pro", :via => [:get]
  end

  # free extensions
  mount DropboxExt::Engine, at: "/dropbox"
  mount Collab::Engine, at: "/collab"

  get "editors/simple_markdown" => "editors#simple_markdown"
  get "editors/simple_markdown_demo" => "editors#simple_markdown_demo"
  get "editors/advanced_markdown_demo" => "editors#advanced_markdown_demo"

  resources "users"
end
