class PagesController < ApplicationController
  include ApplicationHelper
  def main
    session[:search_type] || search_type('freelancer')
  end

  def search
    if search_type? == 'freelancer'
      @peoples = @q.result(distinct: true).includes(:freelancer_info)
    else
      @projects = @j.result(distinct: true)
    end
  end
end
