require 'test_helper'

class ItemsControllerTest < ActionController::TestCase
  setup do
    @item = items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:items)
  end

  test "should create item" do
    AWS.config(:access_key_id => "TESTKEY", :secret_access_key => "TESTSECRET", :stub_requests => true)
    @image = fixture_file_upload('/files/test.gif', 'image/gif')
    assert_difference('Item.count') do
      post :create, item: { image: @image}, id: ENV['GYAZO_ID']
    end

    assert_response :success
  end

  test "should show item" do
    AWS.config(:access_key_id => "TESTKEY", :secret_access_key => "TESTSECRET", :stub_requests => true)
    names = @item.image_file_name.split('.')
    get :show, name: names.shift, format: names.shift
    assert_response :success
  end

  test "should destroy item" do
    AWS.config(:access_key_id => "TESTKEY", :secret_access_key => "TESTSECRET", :stub_requests => true)
    assert_difference('Item.count', -1) do
      names = @item.image_file_name.split('.')
      delete :destroy, id: ENV['GYAZO_ID'], name: names.shift, format: names.shift
    end

    assert_response :success
  end
end
