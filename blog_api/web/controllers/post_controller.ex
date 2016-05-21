defmodule BlogApi.PostController do
  use BlogApi.Web, :controller

  alias BlogApi.Post

  plug :scrub_params, "data" when action in [:create, :update]

  def index(conn, _params) do
    posts = Post |> Repo.all |> Repo.preload([:comments])
    render(conn, "index.json", posts: posts)
  end

  def create(conn, %{"data" => %{"attributes" => post_params}}) do
    changeset = Post.changeset(%Post{comments: []}, post_params)

    case Repo.insert(changeset) do
      {:ok, post} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", post_path(conn, :show, post))
        |> render("show.json", post: post)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(BlogApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Post |> Repo.get!(id) |> Repo.preload([:comments])
    render(conn, "show.json", post: post)
  end

  def update(conn, %{"id" => id, "data" => %{"attributes" => post_params}}) do
    post = Post |> Repo.get!(id) |> Repo.preload([:comments])
    changeset = Post.changeset(post, post_params)

    case Repo.update(changeset) do
      {:ok, post} ->
        render(conn, "show.json", post: post)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(BlogApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Repo.get!(Post, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(post)

    send_resp(conn, :no_content, "")
  end
end
