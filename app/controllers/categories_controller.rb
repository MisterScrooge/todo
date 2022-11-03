class CategoriesController < ApplicationController
  before_action :set_category, only: [ :show, :edit, :update, :destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @categories = current_user.categories
  end

  def show
    @overdue = @category.tasks.where("due_date < ?", Date.current)
    @today = @category.tasks.where("due_date = ?", Date.current)
    @someday = @category.tasks.where("due_date > ?", Date.current)
  end

  def new
    # @category = Category.new
    @category = current_user.categories.build
  end

  def edit
  end

  def create
    # @category = Category.new(category_params)
    @category = current_user.categories.build(category_params)

    if @category.save
      redirect_to categories_path
    else
      render :new, status: :unprocessable_entity
    end

    # Scaffold default

    # respond_to do |format|
    #   if @category.save
    #     format.html { redirect_to category_url(@category), notice: "Category was successfully created." }
    #     format.json { render :show, status: :created, location: @category }
    #   else
    #     format.html { render :new, status: :unprocessable_entity }
    #     format.json { render json: @category.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  def update
    if @category.update(category_params)
      redirect_to category_path(@category), notice: "Category was successfully updated."
    else
      render :edit
    end

    # Scaffold default

    # respond_to do |format|
    #   if @category.update(category_params)
    #     format.html { redirect_to category_url(@category), notice: "Category was successfully updated." }
    #     format.json { render :show, status: :ok, location: @category }
    #   else
    #     format.html { render :edit, status: :unprocessable_entity }
    #     format.json { render json: @category.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  def destroy
    @category.destroy

    redirect_to categories_path, notice: "Category was successfully destroyed."

    # Scaffold default

    # respond_to do |format|
    #   format.html { redirect_to categories_url, notice: "Category was successfully destroyed." }
    #   format.json { head :no_content }
    # end
  end

  def correct_user
    @category = current_user.categories.find_by(id: params[:id])
    redirect_to categories_path, notice: "Not Authorized to edit this category" if @category.nil?
  end

  private
    def set_category
      # @category = Category.find(params[:id])                        # Find the category id
      @category = current_user.categories.find_by(id: params[:id])    # With regards to user, find cat id
    end

    def category_params
      params.require(:category).permit(:cat_name, :user_id)
    end
end
