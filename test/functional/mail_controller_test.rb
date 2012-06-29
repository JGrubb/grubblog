require 'test_helper'

class MailControllerTest < ActionController::TestCase
  test "should get contact" do
    get :contact
    assert_response :success
  end

end
