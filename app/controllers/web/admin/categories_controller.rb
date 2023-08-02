class Web::Admin::CategoriesController < Web::Admin::ApplicationController
  def index
    @q = Category.ransack(params[:q])
    @q.sorts = 'name asc' if @q.sorts.empty?
    @categories = @q.result(distinct: true)
  end

  def new
    @category = CategoryForm.new
  end

  def edit
    category = Category.find params[:id]
    @category = category.becomes(CategoryForm)
  end

  def create
    @category = CategoryForm.new(params[:category_form])

    if @category.valid?
      @category.save!
      f :success, redirect: admin_categories_path
    else
      f :error, now: true, render: :new, status: :unprocessable_entity
    end
  end

  def update
    category = Category.find params[:id]
    @category = category.becomes(CategoryForm)

    @category.assign_attributes(params[:category_form])

    if @category.valid?
      @category.save!
      f :success, redirect: admin_categories_path
    else
      f :error, now: true, render: :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category = Category.find params[:id]
    # TODO: Forbid destroying if has bulletins
    # @category.destroy

    f :success, redirect_back: true, redirect: admin_categories_path
  end
end
