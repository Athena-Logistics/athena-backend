defmodule AthenaWeb.Schema.Location do
  @moduledoc false

  use AthenaWeb, :subschema

  alias Athena.Inventory.Location

  node object(:location) do
    field :name, non_null(:string)
    field :event, non_null(:event), resolve: dataloader(RepoDataLoader)

    connection field :movements_in, node_type: :movement do
      resolve many_dataloader()
    end

    connection field :movements_out, node_type: :movement do
      resolve many_dataloader()
    end

    connection field :stock, node_type: :stock_entry do
      resolve &Resolver.stock/3
    end

    field :inserted_at, non_null(:datetime)
    field :updated_at, non_null(:datetime)

    is_type_of(&match?(%Location{}, &1))

    interface :resource
  end

  connection(node_type: :location, non_null: true)

  object :location_queries do
    @desc "Get Location By ID"
    field :location, :location do
      arg :id, non_null(:id)

      resolve(&Resolver.location/3)
    end
  end
end