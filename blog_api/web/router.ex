defmodule BlogApi.Router do
  use BlogApi.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json", "json-api"]
    plug JaSerializer.ContentTypeNegotiation
    plug JaSerializer.Deserializer
  end

  scope "/", BlogApi do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", BlogApi do
  #   pipe_through :api
  # end
  scope "/api", BlogApi do
    pipe_through :api

    resources "/posts", PostController, except: [:new, :edit] do
      resources "/comments", CommentController, except: [:new, :edit]
    end
  end
end
