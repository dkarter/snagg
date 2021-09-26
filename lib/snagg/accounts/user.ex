defmodule Snagg.Accounts.User do
  @moduledoc false

  use Ecto.Schema

  @type t :: %__MODULE__{
          email: binary(),
          first_name: binary(),
          last_name: binary(),
          avatar_url: binary() | nil,
          oauth_data: map() | nil
        }

  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:email, :first_name, :last_name, :avatar_url]}

  # uuid primary keys
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_params [:email, :first_name, :last_name]
  @permitted_params @required_params ++ [:avatar_url, :oauth_data]

  schema "users" do
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :avatar_url, :string
    field :oauth_data, :map

    timestamps()
  end

  def changeset(%__MODULE__{} = user, params) do
    user
    |> cast(params, @permitted_params)
    |> validate_required(@required_params)
    |> validate_format(:email, ~r/.+@.+\..+/)
    |> unique_constraint(:email)
  end
end
