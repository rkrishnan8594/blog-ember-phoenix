defmodule BlogApi.PostView do
  use BlogApi.Web, :view
  use JaSerializer.PhoenixView
  attributes [:id, :title, :author, :summary]
  has_many :comments, link: "/posts/:id/comments", serializer: BlogApi.CommentView, include: true
end
