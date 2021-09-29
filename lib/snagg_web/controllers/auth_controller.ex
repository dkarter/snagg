defmodule SnaggWeb.AuthController do
  use SnaggWeb, :controller

  plug Ueberauth

  @spec delete(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def delete(conn, _params) do
    conn
    |> put_flash(:info, "You have been logged out!")
    |> clear_session()
    |> redirect(to: "/")
  end

  @spec callback(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    user = Snagg.Accounts.find_or_create_user_from_auth(auth)

    conn
    |> put_flash(:info, "Successfully authenticated.")
    |> put_session(:current_user, user)
    |> configure_session(renew: true)
    |> redirect(to: "/home")
  end
end
