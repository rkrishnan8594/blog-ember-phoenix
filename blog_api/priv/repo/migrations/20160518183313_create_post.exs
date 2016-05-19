defmodule BlogApi.Repo.Migrations.CreatePost do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :author, :string
      add :summary, :text

      timestamps
    end

  end
end
