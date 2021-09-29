defmodule Snagg.Accounts do
  @moduledoc """
  Manages accounts on the app
  """

  alias __MODULE__.User

  @spec create_user(map()) :: {:ok, User.t()} | {:error, Ecto.ChangeError}
  def create_user(params) do
    %User{}
    |> User.changeset(params)
    |> Snagg.Repo.insert()
  end

  @doc """
  Finds and returns a user's account from auth data if it exist, otherwise
  creates a new account
  """
  def find_or_create_user_from_auth(auth_data) do
    %{info: %{email: email, first_name: first_name, last_name: last_name, image: avatar_url}} =
      auth_data

    case user_by_email(email) do
      %User{} = user ->
        user

      nil ->
        # create user
        {:ok, user} =
          create_user(%{
            email: email,
            first_name: first_name,
            last_name: last_name,
            avatar_url: avatar_url
          })

        user
    end
  end

  defp user_by_email(email) do
    Snagg.Repo.get_by(User, email: email)
  end
end
