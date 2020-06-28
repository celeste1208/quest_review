module LoginSupport
  def log_in_with(email, password)
    visit new_user_session_path
    fill_in 'user_email', with: email
    fill_in 'user_password', with: password
    click_button 'Log in'
  end
end

RSpec.configure do |config|
  config.include LoginSupport
end
