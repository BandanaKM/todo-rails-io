class TodosController < ApplicationController
  
  def index
    @todos = Todo.where(completed: false)
    @completes = Todo.where(completed: true)
  end

  def show
    @section = Todo.find(params[:id])
  end

  def new
    @todo = Todo.new
  end

  def create
    @todo = Todo.new(todo_params)
      if @todo.save
        flash[:notice] = "Todo item created successfully." 
        redirect_to(:action => 'index')
      else
        render :new 
      end
  end

  def edit
    @todo = Todo.find(params[:id])
    # unauthorized! if cannot :update, @todo
  end


  def update
    @todo = Todo.find(params[:id])
      if @todo.update_attributes(todo_params)
        flash[:notice] = "Your todo item has been edited!"
        redirect_to(:action => 'index')
      else
        flash[:notice] = "Your todo item could not be edited."
        redirect_to(:action => 'index')
      end
  end

  def complete
    @todo = Todo.find(params[:id])
      if @todo.update_attribute(:completed, true)
        flash[:notice] = "Your todo item is marked as completed!"
        redirect_to(:action => 'index')
      else
        flash[:notice] = "Your todo item could not be marked as completed."
        redirect_to(:action => 'index')
      end
  end

  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy
    redirect_to(:action => 'index')
  end


  private

    def todo_params
      params.require(:todo).permit(:name, :completed)
    end
end
