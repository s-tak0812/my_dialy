class Public::TodoContentsController < ApplicationController
  before_action:authenticate_customer!
  before_action:ensure_correct_customer, only:[:destroy]

  # todo_listのindexにあるtodo_listとtodo_contentの新規投稿ができるリンク
  def new
    @todo_content = TodoContent.new
    @todo_lists = current_customer.todo_lists
  end

  # todo_listとtodo_contentの新規投稿をする
  # または、既存のtodo_listに対してtodo_contentを新規投稿する
  def create
    @todo_content = current_customer.todo_contents.new(todo_content_params)
    # todo_list(タイトル)を選択
    if params[:todo_content][:select_button] == "selected"
      @todo_list = TodoList.find(params[:todo_content][:todo_list_id])
      @todo_content.todo_list_id = @todo_list.id
    # 新しくtodo_listを作る
    elsif params[:todo_content][:select_button] == "new"
      @title = params[:todo_content][:title]
      if @title.nil?
        @todo_lists = current_customer.todo_lists
        render :new
        return
      else
        # todo_listの新規作成
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
      # todo_contentの作成が失敗した時に
      # 新しく作成したtodo_listのみ作成がされてしまうので
      # 状態を戻すために削除する
      if @new_todo_list.present?
        @new_todo_list.destroy
        @todo_lists = current_customer.todo_lists
        render :new
        return
      else
        @todo_lists = current_customer.todo_lists
        render :new
      end
    end
  end

  # todo_listのshowにあるtodo_contentの新規投稿ができるリンク
  def new_content
    @todo_content = TodoContent.new
    @todo_list = TodoList.find(params[:id])
  end

  # todo_contentのみの新規投稿
  def content_create
    @todo_content = current_customer.todo_contents.new(todo_content_params)

    if @todo_content.save
      redirect_to todo_list_path(@todo_content.todo_list_id)
    else
      @todo_list = TodoList.find(params[:id])
      render :new_content
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
