Rails.application.routes.draw do

  # pro extensions
  scope path: ":user_key/:email", :constraints => { :email => /[^\/]+/ } do
    mount Revisions::Engine, at: "/revisions", constraints: lambda { |request|
      email = request.params[:email]
      user = User.find_by_email(email)
      return user && request.params[:user_key] == user.key && user.pro_enabled
    }

    match "/revisions" => "users#expired_pro", :via => [:get]
  end

  # free extensions
  mount DropboxExt::Engine, at: "/dropbox"

  resources "users"
end
