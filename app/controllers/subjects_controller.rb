class SubjectsController < ApplicationController
  before_action :authenticate_user!, :authenticate_supervisor!

  def index
    @subjects = Subject.newest.page(params[:page]).per 9
  end
end
