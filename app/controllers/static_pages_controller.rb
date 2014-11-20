class StaticPagesController < ApplicationController
  def home
    @abc = "this is the alphabet"
  end

  def help
  end

  def about
  end

  def contact
  end
end