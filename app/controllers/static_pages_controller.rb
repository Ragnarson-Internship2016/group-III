class StaticPagesController < ApplicationController
  def about
    render template: "about/about"
  end

  def landing_page
    @skip_footer = true
    @skip_header = true
    render template: "layouts/landing_page"
  end
end
