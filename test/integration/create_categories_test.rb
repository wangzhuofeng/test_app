require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest
  def setup
   @adminuser = User.create(username: "admin", email: "admin@example.com", password: "password", admin: true)
  end
  
  test "create new category" do
   sign_in_as(@adminuser, "password")
   get new_category_path
   assert_template 'categories/new'
   assert_difference 'Category.count', 1 do
     post_via_redirect categories_path, category: {name: "sports"}
   end
   assert_template 'categories/index'
   assert_match 'sports', response.body
  end
  
  test "create invalid category and not successful" do
   sign_in_as(@adminuser, "password")
   get new_category_path
   assert_template 'categories/new'
   assert_no_difference 'Category.count' do
     post_via_redirect categories_path, category: {name: " "}
   end
   assert_template 'categories/new'
   assert_select 'h2.panel-title'
   assert_select 'div.panel-body'
  end
end