defmodule BlogApi.PostView do
  use BlogApi.Web, :view
  use JaSerializer.PhoenixView

  attributes [:id, :title, :author, :summary]

  has_many :comments, link: "/posts/:id/comments", serializer: BlogApi.CommentView, include: true

  def render("index.json", %{posts: posts}) do
    %{data: render_many(posts, BlogApi.PostView, "post.json")}
  end

  def render("show.json", %{post: post}) do
    %{data: render_one(post, BlogApi.PostView, "post.json")}
  end

  def render("post.json", %{post: post}) do
    %{id: post.id,
      title: post.title,
      author: post.author,
      summary: post.summary,
      num_comments: post.comments}
  end
end
