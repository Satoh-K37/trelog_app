class StaticPagesController < ApplicationController
  skip_before_action :login_required

  def home
    # Welcom画面のためのレイアウトを表示させる。staticpages.html.slim
    render layout: 'staticpages'
  end

  def about
    render layout: 'application'
  end
end
