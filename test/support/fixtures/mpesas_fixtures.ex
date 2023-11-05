defmodule Payment.MpesasFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Payment.Mpesas` context.
  """

  @doc """
  Generate a mpesa.
  """
  def mpesa_fixture(attrs \\ %{}) do
    {:ok, mpesa} =
      attrs
      |> Enum.into(%{
        amount: 120.5,
        message: "some message",
        status: 42,
        success: true,
        transaction_code: "some transaction_code",
        transaction_reference: "some transaction_reference"
      })
      |> Payment.Mpesas.create_mpesa()

    mpesa
  end
end
