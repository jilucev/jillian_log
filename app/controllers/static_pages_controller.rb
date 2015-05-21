class StaticPagesController < ApplicationController
  def home
    @current_color = current_user.color
  end

  def help
  end

  def about
  end

  def contact
  end
end
