class Public::TodoListsController < ApplicationController
  before_action:authenticate_customer!
  before_action:ensure_correct_customer, only:[:show, :edit, :update, :destroy]

  def index
    @todo_lists = current_customer.todo_lists
  end

  def show
    @todo_list = TodoList.find(params[:id])
  end

  def edit
  end

  def update
    @todo_list = TodoList.find(params[:id])
    if @todo_list.update(todo_list_params)
      redirect_to :index
    else
      render :edit
    end
  end

  def destroy
    @todo_list = TodoList.find(params[:id])
    @todo_list.destroy
    redirect_to :index
  end


  private

  def todo_list_params
    params.require(:todo_list).permit(:title)
  end

  def ensure_correct_customer
    @todo_content = TodoContent.find(params[:id])
    unless @todo_content.customer == current_customer
      redirect_to root_path
    end
  end

end
