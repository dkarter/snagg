defmodule SnaggWeb.Controllers.AuthControllerTest do
  use SnaggWeb.ConnCase

  describe "POST /auth/google/callback" do
    test "redirects user to homepage and sets session upon a successful login", %{conn: conn} do
      # emulate hydrated assigns from the Ueberauth plug
      conn =
        conn
        |> assign(:ueberauth_auth, Fixtures.Auth.successful_auth_response())
        |> post(Routes.auth_path(conn, :callback, :google))

      assert Routes.live_path(conn, SnaggWeb.HomeLive) == redirected_to(conn, 302)

      assert %{"current_user" => %Snagg.Accounts.User{email: "test@example.com"}} =
               get_session(conn)
    end

    test "redirects user to root when not properly authenticated login", %{conn: conn} do
      conn =
        conn
        |> assign(:ueberauth_failure, [])
        |> post(Routes.auth_path(conn, :callback, :google))

      assert Routes.page_path(conn, :index) == redirected_to(conn, 302)
      assert %{"error" => "Failed to authenticate."} = get_flash(conn)
    end
  end

  describe "DELETE /logout" do
    test "clears the session", %{conn: conn} do
      # emulate hydrated assigns from the Ueberauth plug
      conn =
        conn
        |> assign(:ueberauth_auth, Fixtures.Auth.successful_auth_response())
        |> post(Routes.auth_path(conn, :callback, :google))
        |> delete(Routes.auth_path(conn, :delete))

      assert Routes.page_path(conn, :index) == redirected_to(conn, 302)
      assert %{"info" => "You have been logged out!"} = get_flash(conn)

      refute conn
             |> get_session()
             |> Map.has_key?("current_user")
    end
  end
end
