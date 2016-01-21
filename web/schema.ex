defmodule Blog.Schema do
  use Absinthe.Schema, type_modules: [Blog.Schema.Types]
  alias Absinthe.Type

  def query do
    %Type.Object{
      fields: fields(
        posts: [
          type: list_of(:post),
          resolve: &Resolver.Post.all/3
        ]
        user: [
          type: :user,
          args: args(
            id: [type: non_null(:id)]
          )
          resolve: &Resolver.User.find/3
        ]
      )
    }
  end

  def mutation do
    %Type.Object{
      fields: fields(
        post: [
          type: :post,
          args: args(
            title: [type: non_null(:string)],
            body: [type: non_null(:string)],
            posted_at: [type: non_null(:time)],
          ),
          resolve: &Resolver.Post.create/3,
        ]
      )
    }
  end
end
