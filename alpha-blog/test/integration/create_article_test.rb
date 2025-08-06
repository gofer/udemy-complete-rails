require "test_helper"

class CreateCategoryTest < ActionDispatch::IntegrationTest
  setup do
    @category = Category.create(name: "Sample")
    @user = User.create(username: "johndoe", email: "johndoe@example.com",
                        password: "password", admin: true)
    sign_in_as(@user)
  end

  test "get new article form and article category" do
    get new_article_path
    assert_response :success
    assert_difference 'Article.count', 1 do
      post articles_path, params: { article: { title: "sample article", description: "sample content", category_ids: [@category.id] } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "sample article", response.body
    assert_match "sample content", response.body
  end
end
