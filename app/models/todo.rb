class Todo < ActiveRecord::Base
  attr_accessible :completed, :description, :list
  belongs_to :user
   validates :description, presence: true
  def complete
    @todo = Todo.find(params[:id])
    @todo.completed = true
    @todo.save
  end
end
