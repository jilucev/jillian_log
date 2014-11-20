class SessionsController < ApplicationController
  def new
    # @session = User.sessions.build
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or user
    else
      flash.now[:error] = "invalid email password combination"
      render 'new'
      #we have to specify 'now' because the flash will persist for one request,
      # but a render doesn't count as a request, so the flash message would persist
      # one request longer than wanted. Calling the 'now' method addresses this problem.
      #Its contents will disappear as soon as there is an additional request.
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
