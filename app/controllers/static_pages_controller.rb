class StaticPagesController < ApplicationController
  def home
    @current_color = current_user.color if current_user
  end

  def help
  end

  def about
  end

  def contact
  end
end
