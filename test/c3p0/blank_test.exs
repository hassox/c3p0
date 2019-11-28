defmodule C3P0.BlankTest do
  use ExUnit.Case, async: true

  alias C3P0.Blank
  alias C3P0.Test.BlankStruct

  test "strings" do
    str = ""
    assert Blank.blank?(str) == true
    assert Blank.present?(str) == false
    assert Blank.presence(str) == nil

    str = "n"
    assert Blank.blank?(str) == false
    assert Blank.present?(str) == true
    assert Blank.presence(str) == str
  end

  test "nil" do
    assert Blank.blank?(nil) == true
    assert Blank.present?(nil) == false
    assert Blank.presence(nil) == nil
  end

  test "binaries" do
    value = <<>>
    assert Blank.blank?(value) == true
    assert Blank.present?(value) == false
    assert Blank.presence(value) == nil

    value = <<1>>
    assert Blank.blank?(value) == false
    assert Blank.present?(value) == true
    assert Blank.presence(value) == value
  end

  test "lists" do
    value = []
    assert Blank.blank?(value) == true
    assert Blank.present?(value) == false
    assert Blank.presence(value) == nil

    value = [:a]
    assert Blank.blank?(value) == false
    assert Blank.present?(value) == true
    assert Blank.presence(value) == value
  end

  test "maps" do
    value = %{}
    assert Blank.blank?(value) == true
    assert Blank.present?(value) == false
    assert Blank.presence(value) == nil

    value = %{foo: :bar}
    assert Blank.blank?(value) == false
    assert Blank.present?(value) == true
    assert Blank.presence(value) == value
  end

  test "tuples" do
    value = {}
    assert Blank.blank?(value) == true
    assert Blank.present?(value) == false
    assert Blank.presence(value) == nil

    value = {:foo, 1}
    assert Blank.blank?(value) == false
    assert Blank.present?(value) == true
    assert Blank.presence(value) == value
  end

  test "MapSet" do
    value = MapSet.new()
    assert Blank.blank?(value) == true
    assert Blank.present?(value) == false
    assert Blank.presence(value) == nil

    value = MapSet.new([:a])
    assert Blank.blank?(value) == false
    assert Blank.present?(value) == true
    assert Blank.presence(value) == value
  end

  test "struct" do
    value = %BlankStruct{}
    assert Blank.blank?(value) == true
    assert Blank.present?(value) == false
    assert Blank.presence(value) == nil

    value = %BlankStruct{name: "not blank"}
    assert Blank.blank?(value) == false
    assert Blank.present?(value) == true
    assert Blank.presence(value) == value
  end
end
