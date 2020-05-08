defprotocol C3P0.GenerateGuid do
  @moduledoc """
  Generate attributes for a new guid given a resource.
  """

  @type generated_attrs :: %{
    id: binary,
    guid: String.t()
  }

  @type parent :: map

  @spec generate_new_attrs(term) :: generated_attrs
  def generate_new_attrs(data)

  @spec generate_new_attrs(term, parent) :: generated_attrs
  def generate_new_attrs(data, parent)
end