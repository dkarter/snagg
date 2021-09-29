defmodule Snagg.AccountsTest do
  use Snagg.DataCase

  alias Snagg.Accounts
  alias Snagg.Accounts.User

  doctest Accounts

  @user_params %{
    email: Fixtures.Auth.email(),
    first_name: Fixtures.Auth.first_name(),
    last_name: Fixtures.Auth.last_name(),
    avatar_url: Fixtures.Auth.avatar_url()
  }

  describe "find_or_create_user_from_auth/1" do
    test "returns an account if it exists and matches the auth data" do
      {:ok, %User{id: existing_user_id}} = Accounts.create_user(@user_params)

      assert %User{id: ^existing_user_id} =
               Accounts.find_or_create_user_from_auth(Fixtures.Auth.successful_auth_response())
    end

    test "creates an account if one does not exist for the email" do
      assert %User{} =
               user =
               Accounts.find_or_create_user_from_auth(Fixtures.Auth.successful_auth_response())

      assert @user_params = user

      refute user.id == nil
    end
  end
end
