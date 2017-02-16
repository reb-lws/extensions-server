class ProConstraint
  def initialize

  end

  def matches?(request)
    email = request.params[:email]
    user = User.find_by_email(email)
    return user && request.params[:user_key] == user.key && user.pro_enabled
  end
end
