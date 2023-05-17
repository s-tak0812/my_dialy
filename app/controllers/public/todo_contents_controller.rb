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
      @todo_list = TodoList.find(params[:todo_content][:todo_list])
      @todo_content.todo_list_id = @todo_list.id

    elsif params[:todo_content][:select_button] == "2"
      @title = params[:title]
      if @title.nil?
        render :new
        return
      else
        @todo_list = TodoList.new(todo_list_params)
        @todo_list.customer_id = current_customer.id
        @todo_list.title = @title
        @todo_list.save
        @todo_content.todo_list_id = @todo_list.id
      end


    else
      redirect_to request.referer
      return
    end

    if @todo_content.save
      redirect_to todo_list_path(todo_content.todo_list_id)
    else
      render :new
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
