defmodule Snagg.Resources do
  @moduledoc """
  Context for managing Resources and Resource Groups
  """

  alias Snagg.Resources.Group

  @spec create_group(binary()) :: {:ok, Group.t()} | {:error, Ecto.Changeset.t()}
  def create_group(name) do
    %Group{}
    |> Group.changeset(%{name: name})
    |> Snagg.Repo.insert()
  end
end
