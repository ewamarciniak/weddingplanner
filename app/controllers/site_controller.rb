class SiteController < ApplicationController
  skip_before_filter :authorize
  def index
    @tab="home"
  end

  def faq
    @tab="faq"
  end

  def coming_soon
    @tab="forum"
  end
end
