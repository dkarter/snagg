defmodule Snagg.Repo do
  use Ecto.Repo,
    otp_app: :snagg,
    adapter: Ecto.Adapters.Postgres
end
