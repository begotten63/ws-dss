class Admin::AdminController < ApplicationController
  def index
    authorize! :index, :admin
  end 
end