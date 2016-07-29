class StaticPagesController < ApplicationController
  def about
    render template: "about/about"
  end

  def landing_page
    if current_user
      redirect_to events_path 
    else
      @skip_footer = true
      @skip_header = true
      render template: "layouts/landing_page"
    end
  end
end
