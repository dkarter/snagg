defmodule SnaggWeb.HomeLive do
  @moduledoc false

  use SnaggWeb, :live_view

  @impl true
  def render(assigns) do
    if assigns.current_user do
      ~H"""
      <div>
      Logged in as <%= @current_user.email %> <%= @current_user.first_name %> <%= @current_user.last_name %>
      </div>
      """
    else
      ~H"""
      <div>
        Not logged in
      </div>
      """
    end
  end

  @impl true
  def mount(_params, session, socket) do
    socket = assign(socket, :current_user, Map.get(session, "current_user"))
    {:ok, socket}
  end
end
