module SignUpSupport
  def sign_up_with(user_name, email, password, password_confirmation)
    visit new_user_registration_path
    fill_in 'user_user_name', with: user_name
    fill_in 'user_email', with: email
    fill_in 'user_password', with: password
    fill_in 'user_password_confirmation', with: password_confirmation
    click_button 'Sign up'
  end
end

RSpec.configure do |config|
  config.include SignUpSupport
end
