class Public::TodoContentsController < ApplicationController
  before_action:authenticate_customer!
  before_action:ensure_correct_customer, only:[:destroy]

  def new
    @todo_content = TodoContent.new
    @todo_lists = current_customer.todo_lists
  end

  def create
    @todo_content = current_customer.todo_contents.new(todo_content_params)
    if params[:todo_content][:select_button] == "1"
      @todo_list = TodoList.find(params[:todo_content][:todo_list_id])
      @todo_content.todo_list_id = @todo_list.id

    elsif params[:todo_content][:select_button] == "2"
      @title = params[:todo_content][:title]
      if @title.nil?
        render :new
        return
      else
        @new_todo_list = TodoList.new
        @new_todo_list.customer_id = current_customer.id
        @new_todo_list.title = @title
        @new_todo_list.save
        @todo_content.todo_list_id = @new_todo_list.id
      end


    else
      redirect_to request.referer
      return
    end

    if @todo_content.save
      redirect_to todo_list_path(@todo_content.todo_list_id)
    else
      if @new_todo_list.present?
        @new_todo_list.destroy
        render :new
        return
      else
        render :new
      end
    end
  end

  def destroy
    @todo_content = TodoContent.find(params[:id])
    @todo_content.destroy
    redirect_to request.referer
  end


  private

  def todo_content_params
    params.require(:todo_content).permit(:content, :todo_list_id)
  end

  def ensure_correct_customer
    @todo_content = TodoContent.find(params[:id])
    unless @todo_content.customer == current_customer
      redirect_to root_path
    end
  end

end
