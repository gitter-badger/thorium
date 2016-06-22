alias GraphQL.Type.List
import RethinkDB.Query, only: [table: 1, get: 2, filter: 2]

defmodule App.Type.Station do
  @type_string %{type: %GraphQL.Type.String{}}

  def get do
    %GraphQL.Type.ObjectType{
      name: "Station",
      fields: %{
        id: @type_string,
        name: @type_string,
        simulatorId: @type_string,
        cards: %{
          type: %List{ofType: App.Type.Card.get},
          resolve: fn (doc, _args, _) ->
            table("cards")
            |> filter(%{stationId: doc.id})
            |> DB.run
            |> DB.handle_graphql_resp
          end
        }
      }
    }
  end
end