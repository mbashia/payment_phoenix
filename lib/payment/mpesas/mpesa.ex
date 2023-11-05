defmodule Payment.Mpesas.Mpesa do
  use Ecto.Schema
  import Ecto.Changeset

  schema "mpesas" do
    field :amount, :float
    field :message, :string
    field :status, :integer
    field :success, :boolean, default: false
    field :transaction_code, :string
    field :transaction_reference, :string

    timestamps()
  end

  @doc false
  def changeset(mpesa, attrs) do
    mpesa
    |> cast(attrs, [
      :message,
      :success,
      :status,
      :amount,
      :transaction_code,
      :transaction_reference
    ])
    |> validate_required([
      :message,
      :success,
      :status,
      :amount,
      :transaction_code,
      :transaction_reference
    ])
  end
end
