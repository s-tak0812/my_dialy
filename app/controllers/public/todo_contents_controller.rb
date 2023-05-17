class Public::TodoContentsController < ApplicationController
  before_action:authenticate_customer!
  before_action:ensure_correct_customer, only:[:destroy]

  def new
    @todo_content = TodoContent.new
  end

  def create
    @todo_content = current_customer.todo_contents.new(todo_content_params)
    if params[:todo_list][:select_adress] == "1"
      @todo_list = TodoList.find(params[:todo_content][:todo_list])
      @todo_content.todo_list_id == @todo_list.id

    elsif params[:todo_list][:select_adress] == "2"
      @title = params[:title]
      @todo_list = current_customer.todo_lists.new(todo_list_params)
      @todo_list.title = @title
      unless @todo_list.save
        render :new
      end

    else
      redirect_to request.referer
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
    params.require(:todo_content).permit(:content)
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
