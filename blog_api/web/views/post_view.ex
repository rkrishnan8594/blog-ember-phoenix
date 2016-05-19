defmodule BlogApi.PostView do
  use BlogApi.Web, :view

  attributes [:id, :title, :author, :summary]

  has_many :comments, link: "/posts/:id/comments"

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
      comments: 5}
  end
end
