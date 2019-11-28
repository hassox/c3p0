defprotocol C3P0.Humanize do
  @moduledoc """
  Converts a data object into a human readable form.

  By default, this will fallback to `Kernel.to_string/1`
  """

  @fallback_to_any true

  @type options :: []

  @spec display(term) :: String.t() | nil
  @spec display(term, options) :: String.t() | nil
  def display(data, options \\ [])
end

defimpl C3P0.Humanize, for: Any do
  def display(data, _ \\ []), do: to_string(data)
end
