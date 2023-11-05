defmodule Payment.ProductsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Payment.Products` context.
  """

  @doc """
  Generate a product.
  """
  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(%{
        amount: 120.5,
        description: "some description",
        name: "some name"
      })
      |> Payment.Products.create_product()

    product
  end
end
