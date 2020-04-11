class StaticPagesController < ApplicationController
  skip_before_action :login_required
  
  def home
  end

  def about
  end
end
