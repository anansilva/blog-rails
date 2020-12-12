class HomeController < ApplicationController
  def show
    @skip_footer = true
    @skip_navbar = true
    render 'show'
  end
end
