class Public::TodoListsController < ApplicationController
  before_action:authenticate_customer!
  before_action:ensure_correct_customer, only:[:show, :destroy]

  def index
    @todo_lists = current_customer.todo_lists
  end

  def show
    @todo_list = TodoList.find(params[:id])
    @todo_contens = TodoContent.where(todo_list_id: @todo_list.id)
  end

  def destroy
    @todo_list = TodoList.find(params[:id])
    @todo_list.destroy
    redirect_to :index
  end


  private

  def ensure_correct_customer
    @todo_content = TodoContent.find(params[:id])
    unless @todo_content.customer == current_customer
      redirect_to root_path
    end
  end

end
