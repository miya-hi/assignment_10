class Admin::LabelsController < ApplicationController
  before_action :exclude_not_admin_user
  def new
    @label = Label.new
  end
  def create
    @label = Label.new(label_params)
    if @label.save
      redirect_to admin_labels_path
    else
      render :new
    end
  end
  def index
    @labels = Label.all
  end
  def destroy
    @label = Label.find(params[:id])
    @label.destroy
      redirect_to admin_labels_path, notice: "#{@label.name}を削除しました"
  end
  private
  def label_params
    params.require(:label).permit(:name)
  end
  def exclude_not_admin_user
    if current_user.admin == false
      redirect_to root_path, notice: "アクセス権限がありません"
    end
  end
end
