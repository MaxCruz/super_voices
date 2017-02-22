require 'test_helper'

class VoicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @voice = voices(:one)
  end

  test "should get index" do
    get voices_url
    assert_response :success
  end

  test "should get new" do
    get new_voice_url
    assert_response :success
  end

  test "should create voice" do
    assert_difference('Voice.count') do
      post voices_url, params: { voice: { creation: @voice.creation, destination_url: @voice.destination_url, done: @voice.done, email: @voice.email, last_name: @voice.last_name, message: @voice.message, name: @voice.name, source_url: @voice.source_url } }
    end

    assert_redirected_to voice_url(Voice.last)
  end

  test "should show voice" do
    get voice_url(@voice)
    assert_response :success
  end

  test "should get edit" do
    get edit_voice_url(@voice)
    assert_response :success
  end

  test "should update voice" do
    patch voice_url(@voice), params: { voice: { creation: @voice.creation, destination_url: @voice.destination_url, done: @voice.done, email: @voice.email, last_name: @voice.last_name, message: @voice.message, name: @voice.name, source_url: @voice.source_url } }
    assert_redirected_to voice_url(@voice)
  end

  test "should destroy voice" do
    assert_difference('Voice.count', -1) do
      delete voice_url(@voice)
    end

    assert_redirected_to voices_url
  end
end
