require 'test_helper'

class WikiFormsControllerTest < ActionController::TestCase
  setup do
    @wiki_form = wiki_forms(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:wiki_forms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create wiki_form" do
    assert_difference('WikiForm.count') do
      post :create, wiki_form: { action: @wiki_form.action, parser_name: @wiki_form.parser_name, url: @wiki_form.url }
    end

    assert_redirected_to wiki_form_path(assigns(:wiki_form))
  end

  test "should show wiki_form" do
    get :show, id: @wiki_form
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @wiki_form
    assert_response :success
  end

  test "should update wiki_form" do
    put :update, id: @wiki_form, wiki_form: { action: @wiki_form.action, parser_name: @wiki_form.parser_name, url: @wiki_form.url }
    assert_redirected_to wiki_form_path(assigns(:wiki_form))
  end

  test "should destroy wiki_form" do
    assert_difference('WikiForm.count', -1) do
      delete :destroy, id: @wiki_form
    end

    assert_redirected_to wiki_forms_path
  end
end
