defmodule Snagg.Fixtures.Auth do
  @avatar_url "https://placehold.co/600x400"
  @email "test@example.com"
  @first_name "Jay"
  @last_name "Smith"

  @successful_auth_response %Ueberauth.Auth{
    credentials: %Ueberauth.Auth.Credentials{
      expires: true,
      expires_at: 1_632_626_377,
      other: %{},
      refresh_token: nil,
      scopes: [
        "openid https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/userinfo.profile"
      ],
      secret: nil,
      token: "access.token",
      token_type: "Bearer"
    },
    info: %Ueberauth.Auth.Info{
      birthday: nil,
      description: nil,
      email: @email,
      first_name: @first_name,
      image: @avatar_url,
      last_name: @last_name,
      location: nil,
      name: "#{@first_name} #{@last_name}",
      nickname: nil,
      phone: nil,
      urls: %{profile: nil, website: "exmaple.com"}
    },
    provider: :google,
    strategy: Ueberauth.Strategy.Google,
    uid: "111111111111111111111"
  }

  def successful_auth_response do
    @successful_auth_response
  end

  def email do
    @email
  end

  def first_name do
    @first_name
  end

  def last_name do
    @last_name
  end

  def avatar_url do
    @avatar_url
  end
end
