defmodule C3P0.Test.IDStruct do
  @derive {C3P0.ID, id_field: :token}
  defstruct [:token]
end

defmodule C3P0.Test.FullIDStruct do
  @derive {C3P0.ID, id_field: :token, guid_field: :the_guid}
  defstruct [:token, :the_guid]
end

defimpl C3P0.ID, for: C3P0.Test.UnknownIDStruct do
  def id(%{unknown_id: id}), do: id
  def guid(%{unknown_guid: id}), do: id
end

defmodule C3P0.Test.UnimplementedStruct do
  defstruct [:id, :guid]
end
