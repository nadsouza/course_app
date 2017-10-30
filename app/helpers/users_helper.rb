module UsersHelper
  def gravatar_url(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
  end

  # Returns the Gravatar for the given user.
  def gravatar_for(user)
    image_tag(gravatar_url(user), alt: "Gravatar", class: "gravatar")
  end
end
