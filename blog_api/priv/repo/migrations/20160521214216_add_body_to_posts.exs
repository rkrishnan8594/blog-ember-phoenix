defmodule BlogApi.Repo.Migrations.AddBodyToPosts do
  use Ecto.Migration

  def change do
  	alter table(:posts) do
  	  add :body, :text
    end
  end
end
