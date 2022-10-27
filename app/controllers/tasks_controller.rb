class TasksController < ApplicationController
    before_action :set_category, only: [ :create, :edit, :update, :destroy ]

    def create
        # @category = current_user.categories.find(params[:category_id])
        @task = @category.tasks.create(task_params)
        redirect_to category_path(@category), notice: "Task successfully created"
    end

    def edit
        @task = @category.tasks.find(params[:id])
    end

    def update
        @task = @category.tasks.find(params[:id])
        if @task.update(task_params)
            redirect_to category_path(@category), notice: "Task was successfully updated"
        else
            render :edit
        end
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
            params.require(:task).permit(:task, :comment, :due_date)
        end
end
