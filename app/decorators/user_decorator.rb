class UserDecorator < Draper::Decorator
  delegate_all

  def image_url
    if image.present?
      image.url
    else
      '/default_user_image/default_user_image.png'
    end
  end
end
