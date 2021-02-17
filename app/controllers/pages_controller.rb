class PagesController < ApplicationController
  def main; end

  def search
    if params[:q] && params[:q].reject { |_k, v| v.blank? }.present?
      @peoples = @q.result(distinct: true).includes(:freelancer_info)
    end
  end
end
