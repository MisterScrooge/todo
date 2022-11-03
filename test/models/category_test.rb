require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "should not save category without name" do
    category = Category.new
    assert_not category.save, "Saved the category without a name"
  end

  test "should report error" do
    assert_raises(NameError) do
      some_undefined_variable
    end
  end

end
