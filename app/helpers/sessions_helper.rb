module SessionsHelper

  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.digest(remember_token))
    self.current_user = user
    #this calls the method below
  end

  def current_user=(user) #holy cow, batman! This is an assignment method.
    @current_user = user
  end

  def current_user
    remember_token = User.digest(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def current_user?(user)
    user == current_user
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    current_user.update_attribute(:remember_token,
                                  User.digest(User.new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end
end

# session is a Rails facility that works kind of like an instance of the 
# cookies variable. It automatically expires upon browser close.

  #def sign_in(user)
        #remember_token = User.new_remember_token #create a new token
        #cookies.permanent[:remember_token] = remember_token 
          #place the raw token in the browser cookies.
          #there is a cookies utility supplied by rails which allows us to manipulate browser cookies as if they were hashes. 
          #(actually, it isn't really a hash. Assigning to cookies just saves a piece of text on the browser)
          #each element in the cookie is a hash of 2 elements, a value and an optional 'expires' date. So we are able to do things
          #like this:
          #cookies[:remember_token] = { value: remember_token,
          #                             expires: 20.years.from_now.utc }
          #this example adds a method to the base class for numbers 'Fixnum' via Rails time helpers.
          #this practice of setting cookies to expire in 20 years
          #became so common that rails added a special permanent method to implement it.
          #So using 'permanent' causes Rails to set the expiration to 20.years.from_now automatically.
          #After the cookie is set, we can retrieve the user with code like this on subsequent page views:
          #User.find_by(remember_token: :remember_token)
    #user.update_attribute(:remember_token, User.digest(remember_token)) 
        #save the hashed token in the database.
        #update_attribute allows us to update a single attribute while bypassing the validations. This is necessary here
        #because we don't have the user's password or password_confirmation.
    #self.current_user = user
        #set the current user as the given user
        #this will never be used due to the automatic redirect on the controller, 
        #but it would be dangerous for this method to rely on that
  #end

        # def sign_in
        #   session[:remember_token] = user.id
        #   User.find(session[:remember_token])
        #   this style of session expires upon browser close
        # end

        # This is a persistent session that gives a user signin status until they explicitly sign out.
        # To accomplish this, we generate a unique, secure remember token which will act as a permanent identifier
        # for the signed-in user. This token needs to be associated with a user and stored for future use, so we add
        #it as an attribute on the User model.
