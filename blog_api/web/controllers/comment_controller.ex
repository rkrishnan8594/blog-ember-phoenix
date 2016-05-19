defmodule BlogApi.CommentController do
  use BlogApi.Web, :controller

  alias BlogApi.Comment
  alias BlogApi.Post

  plug :scrub_params, "comment" when action in [:create, :update]
  plug :assign_post

  def index(conn, _params) do
    comments = Repo.all(assoc(conn.assigns[:post], :comments))
    render(conn, "index.json", comments: comments)
  end

  def create(conn, %{"comment" => comment_params}) do
    changeset = conn.assigns[:post]
     |> build_assoc(:comments)
     |> Comment.changeset(comment_params)

    case Repo.insert(changeset) do
      {:ok, comment} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", post_comment_path(conn, :show, conn.assigns[:post], comment))
        |> render("show.json", comment: comment)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(BlogApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    comment = Repo.get!(assoc(conn.assigns[:post], :comments), id)
    render(conn, "show.json", comment: comment)
  end

  def update(conn, %{"id" => id, "comment" => comment_params}) do
    comment = Repo.get!(assoc(conn.assigns[:post], :comments), id)
    changeset = Comment.changeset(comment, comment_params)

    case Repo.update(changeset) do
      {:ok, comment} ->
        render(conn, "show.json", comment: comment)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(BlogApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    comment = Repo.get!(assoc(conn.assigns[:post], :comments), id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(comment)

    send_resp(conn, :no_content, "")
  end

  defp assign_post(conn, _) do
    %{"post_id" => post_id} = conn.params
    if post = Repo.get(Post, post_id) do
      assign(conn, :post, post)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(BlogApi.ChangesetView, "error.json", message: "Post Not Found")
    end
  end
end
