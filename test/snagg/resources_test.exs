defmodule Snagg.ResourcesTest do
  use Snagg.DataCase

  describe "create_group/1" do
    test "creates a resource group" do
      assert {:ok, %Snagg.Resources.Group{id: group_id}} =
               Snagg.Resources.create_group("Dev Servers")

      refute is_nil(group_id)
    end

    test "returns an error and does not create group when name already exists" do
      assert {:ok, _server} = Snagg.Resources.create_group("Dev Servers")
      assert {:error, changeset} = Snagg.Resources.create_group("Dev Servers")
      assert errors_on(changeset) == %{name: ["has already been taken"]}
    end
  end
end
