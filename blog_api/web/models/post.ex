defmodule BlogApi.Post do
  use BlogApi.Web, :model

  schema "posts" do
    field :title, :string
    field :author, :string
    field :summary, :string
    field :body, :string

    has_many :comments, BlogApi.Comment

    timestamps
  end

  @required_fields ~w(title author summary)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
