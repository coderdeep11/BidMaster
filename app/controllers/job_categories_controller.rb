class JobCategoriesController < ApplicationController
  include JobCategoriesHelper
  def show
    @job = job(params[:id])
    render json: @job
  end
end
