class FreelancerInfosController < ApplicationController
  def index
    @projects = Project.all
  end

  def create; end

  def edit; end

  def update; end
end
