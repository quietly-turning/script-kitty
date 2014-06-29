require 'test_helper'

class InstitutionsControllerTest < ActionController::TestCase
  setup do
    @institution = institutions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:institutions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create institution" do
    assert_difference('Institution.count') do
      post :create, institution: { chief: @institution.chief, city: @institution.city, control_id: @institution.control_id, level_id: @institution.level_id, locale_id: @institution.locale_id, name: @institution.name, state: @institution.state, zip: @institution.zip }
    end

    assert_redirected_to institution_path(assigns(:institution))
  end

  test "should show institution" do
    get :show, id: @institution
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @institution
    assert_response :success
  end

  test "should update institution" do
    patch :update, id: @institution, institution: { chief: @institution.chief, city: @institution.city, control_id: @institution.control_id, level_id: @institution.level_id, locale_id: @institution.locale_id, name: @institution.name, state: @institution.state, zip: @institution.zip }
    assert_redirected_to institution_path(assigns(:institution))
  end

  test "should destroy institution" do
    assert_difference('Institution.count', -1) do
      delete :destroy, id: @institution
    end

    assert_redirected_to institutions_path
  end
end
