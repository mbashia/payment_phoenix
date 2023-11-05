defmodule Payment.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string
      add :description, :string
      add :amount, :float

      timestamps()
    end
  end
end
