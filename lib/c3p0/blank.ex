defprotocol C3P0.Blank do
  @moduledoc """
  Provides a blankness check to see if something is blank/present

  Empty lists, maps, strings, tuples and binaries are considered blank, as is nil.

  Default structs are also considered blank
  """

  @fallback_to_any true

  @doc "true if the data is blank"
  @spec blank?(term) :: boolean
  def blank?(data)

  @doc "true if the data is not blank"
  @spec present?(term) :: boolean
  def present?(data)

  @doc "Returns the value if present or nil"
  @spec presence(term) :: term | nil
  def presence(data)
end

defimpl C3P0.Blank, for: Any do
  @blank ["", nil, [], %{}, <<>>, {}]

  def blank?(%mod{} = data), do: mod.__struct__() == data
  def blank?(data), do: data in @blank

  def present?(data), do: not C3P0.Blank.blank?(data)

  def presence(data) do
    if C3P0.Blank.blank?(data) do
      nil
    else
      data
    end
  end
end

defimpl C3P0.Blank, for: MapSet do
  def blank?(ms), do: MapSet.size(ms) == 0
  def present?(ms), do: not C3P0.Blank.blank?(ms)
  def presence(ms) do
    if MapSet.size(ms) == 0 do
      nil
    else
      ms
    end
  end
end
