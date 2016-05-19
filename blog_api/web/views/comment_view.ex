defmodule BlogApi.CommentView do
  use BlogApi.Web, :view

  attributes [:id, :author, :content, :post_id]

  def render("index.json", %{comments: comments}) do
    %{data: render_many(comments, BlogApi.CommentView, "comment.json")}
  end

  def render("show.json", %{comment: comment}) do
    %{data: render_one(comment, BlogApi.CommentView, "comment.json")}
  end

  def render("comment.json", %{comment: comment}) do
    %{id: comment.id,
      author: comment.author,
      content: comment.content,
      post_id: comment.post_id}
  end
end
