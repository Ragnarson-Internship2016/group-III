class StaticPagesController < ApplicationController
  def about
    render template: "about/about"
  end
end
