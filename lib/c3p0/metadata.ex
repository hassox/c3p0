defprotocol C3P0.Metadata do
  @moduledoc """
  Provide access to a bare map of metadata about a struct
  """

  @spec metadata(term()) :: map()
  def metadata(term)
end