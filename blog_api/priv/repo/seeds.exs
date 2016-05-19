# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     BlogApi.Repo.insert!(%BlogApi.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias BlogApi.Repo
alias BlogApi.Post
alias BlogApi.Comment

[
  %Post{
    title: "Post 1",
    author: "Rowan Krishnan",
    summary: "Lorem ipsum dolor"
  },
  %Post{
    title: "Post 2",
    author: "Mark Twain",
    summary: "Blah Blah Blah"
  },
  %Post{
    title: "Post 3",
    author: "Toni Morrison",
    summary: "This is a summary"
  }
] |> Enum.each(&Repo.insert!(&1))

comments = [
  %{
    author: "Foo Bar",
    content: "Here is my comment for your blog post",
  },
  %{
    author: "Firstname Lastname",
    content: "Lorem ipsum dolor",
  },
  %{
    author: "Internet Commenter",
    content: "I really enjoyed this post"
  },
]

Repo.transaction fn ->
  Repo.all(Post) |> Enum.each(fn(post) ->
    Enum.each(comments, fn(comment) ->
      new_comment = Ecto.build_assoc(post, :comments, Map.put(comment, :post_id, post.id))
      Repo.insert!(new_comment)
    end)
  end)
end
