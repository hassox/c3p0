defprotocol C3PO.GenerateGuid do
  @moduledoc """
  Generate attributes for a new guid given a resource.
  """

  @type generated_attrs :: %{
    id: binary,
    guid: String.t()
  }

  @type child_type :: atom

  @spec generate_new_attrs(term) :: generated_attrs
  def generate_new_attrs(data)

  @spec generate_new_attrs(term, child_type) :: generated_attrs
  def generate_new_attrs(data, child_type)
end