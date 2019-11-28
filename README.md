# C3P0

C3P0 contains protocol definitions. 

Centralizing these definitions, it is hoped that libraries and applications will make use of them to make data more portable between components of a system.

# Protocols

## ID

This protocol standardizes finding an ID for a peice of data.

There are two functions in this protocol:

1. `C3P0.ID.id(data)` 
2. `C3P0.ID.guid(data)`

By default the guid will fall back to the id.

This will work on all structs and maps which have fields `id` (and optionally `guid`)

To customize for your struct if there are different fields, derive the `C3P0.ID` protocol.

```elixir
defmodule MyStruct do
  @derive {C3P0.ID, id_field: :local_id, guid_field: :global_id}
  defstruct [:local_id, :global_id]
end
```

## Humanize

The `C3P0.Humanize` protocol displays as a string the data provided.

Falls back to a simple `to_string`

## Blank

The `C3P0.Blank` protocol deals with blankness.

Empty strings, bbinaries, lists, maps and tuples are considered `blank?` along with `nil`.

The protocol defines 3 functions:

* `blank?(data)` - true/false
* `present?(data)` - true/false
* `presence(data)` - returns the value if it is not blank. nil if it is blank



## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `c3p0` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:c3p0, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/c3p0](https://hexdocs.pm/c3p0).

