class TasksController < ApplicationController
    before_action :set_category, only: [ :create, :destroy ]

    def create
        # @category = current_user.categories.find(params[:category_id])
        @task = @category.tasks.create(task_params)
        redirect_to category_path(@category)
    end

    def destroy
        @task = @category.tasks.find(params[:id])
        @task.destroy
        redirect_to category_path
    end

    private
        def set_category
            @category = current_user.categories.find(params[:category_id])
        end

        def task_params
            params.require(:task).permit(:task, :comment)
        end
end
