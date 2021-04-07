module Admin
  class DashboardsController < ApplicationController
    before_action :authorized_only_to_admin!
    def index; end
  end
end
