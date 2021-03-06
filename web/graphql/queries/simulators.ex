alias GraphQL.Type.List
import RethinkDB.Query, only: [table: 1]

defmodule App.Query.Simulators do
  def get do
    %{
      type: %List{ofType: App.Type.Simulator.get},
      resolve: fn (_, _args, _) ->
        table("simulators")
        |> DB.run
        |> DB.handle_graphql_resp
      end
    }
  end
end
