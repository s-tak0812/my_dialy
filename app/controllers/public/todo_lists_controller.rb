class Public::TodoListsController < ApplicationController
  before_action:authenticate_customer!
  before_action:ensure_correct_customer, only:[:show, :destroy]

  def index
    @todo_lists = current_customer.todo_lists
  end

  def show
    @todo_list = TodoList.find(params[:id])
    @todo_contents = TodoContent.where(todo_list_id: @todo_list.id)
  end

  def destroy
    @todo_list = TodoList.find(params[:id])
    @todo_list.destroy
    redirect_to todo_lists_path
  end


  private

  def ensure_correct_customer
    @todo_list = TodoList.find(params[:id])
    unless @todo_list.customer == current_customer
      redirect_to root_path
    end
  end

end
