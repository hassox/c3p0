defprotocol C3P0.ID do
  @moduledoc """
  Formalizes fetching the ID from data.

  For maps the keys `id`, `"id"` are considered id fields and `guid`, `"guid"` are considered guid fields.

  When requesting a guid, if one cannot be found by default it will fall back to the id.

  ## Using with your own structs

  By default your own structs will behave the same way as a map.
  However if you need to redefine which field should be considered the id/guid fields you'll need to derive the protocol.

  ```elixir
    defmodule MyStruct do
      @derive {C3P0.ID, id_field: :token, guid_field: :arn}
      defstruct [:token, :arn, :name]
    end
  ```
  """

  @fallback_to_any true

  @doc "Find the id of a piece of data"
  @spec id(term) :: binary | nil
  def id(data)

  @doc "Find a global id for a piece of data"
  @spec guid(term) :: binary | nil
  def guid(data)
end

defimpl C3P0.ID, for: [PID, Reference] do
  def id(pid), do: pid
  def guid(pid), do: pid
end

defimpl C3P0.ID, for: Any do
  defmacro __deriving__(module, _struct, options) do
    quote do
      defimpl C3P0.ID, for: unquote(module) do
        opts = unquote(options)
        id_field = Keyword.get(opts, :id_field)
        guid_field = Keyword.get(opts, :guid_field) || id_field

        unless id_field, do: raise "id field not provided to derive #{unquote(module)}"

        @id_field id_field
        @guid_field guid_field

        def id(item), do: Map.get(item, @id_field)
        def guid(item), do: Map.get(item, @guid_field)
      end
    end
  end

  def id(id) when is_binary(id), do: id
  def id(id) when is_atom(id), do: id
  def id(id) when is_number(id), do: id
  def id(%{id: id}), do: id
  def id(%{"id" => id}), do: id

  def id(%{uuid: id}), do: id
  def id(%{"uuid" => id}), do: id

  def id(%{guid: id}), do: id
  def id(%{"guid" => id}), do: id
  def id(%{}), do: nil
  def id(nil), do: nil
  def id(v) do
    raise Protocol.UndefinedError, protocol: C3P0.ID, value: v, description: "unknown value for id"
  end

  def guid(%{guid: id}), do: id
  def guid(%{"guid" => id}), do: id
  def guid(%{uuid: id}), do: id
  def guid(%{"uuid" => id}), do: id
  def guid(id), do: C3P0.ID.id(id)
end
