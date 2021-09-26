defmodule Snagg.AccountsTest do
  use Snagg.DataCase

  alias Snagg.Accounts
  alias Snagg.Accounts.User

  doctest Accounts

  @avatar_url "https://placehold.co/600x400"
  @email "test@example.com"
  @first_name "Jay"
  @last_name "Smith"

  @auth_response_fixture %Ueberauth.Auth{
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

  describe "find_or_create_user_from_auth/1" do
    test "returns an account if it exists and matches the auth data" do
      {:ok, %User{id: existing_user_id}} =
        Accounts.create_user(%{
          email: @email,
          first_name: @first_name,
          last_name: @last_name,
          avatar_url: @avatar_url
        })

      assert %User{id: ^existing_user_id} =
               Accounts.find_or_create_user_from_auth(@auth_response_fixture)
    end

    test "creates an account if one does not exist for the email" do
      assert user = Accounts.find_or_create_user_from_auth(@auth_response_fixture)

      assert %User{
               email: @email,
               first_name: @first_name,
               last_name: @last_name,
               avatar_url: @avatar_url
             } = user

      refute user.id == nil
    end
  end
end
