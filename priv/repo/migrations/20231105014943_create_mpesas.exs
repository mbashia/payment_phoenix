defmodule Payment.Repo.Migrations.CreateMpesas do
  use Ecto.Migration

  def change do
    create table(:mpesas) do
      add :message, :string
      add :success, :boolean, default: false, null: false
      add :status, :integer
      add :amount, :float
      add :transaction_code, :string
      add :transaction_reference, :string

      timestamps()
    end
  end
end
