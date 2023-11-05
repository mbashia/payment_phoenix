defmodule Payment.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :amount, :float
    field :description, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :description, :amount])
    |> validate_required([:name, :description, :amount])
  end
end
