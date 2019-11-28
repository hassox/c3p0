defmodule C3P0.IDTest do
  use ExUnit.Case, async: true
  alias C3P0.ID
  alias C3P0.Test.{IDStruct, FullIDStruct, UnknownIDStruct, UnimplementedStruct}

  describe "id/1" do
    test "map" do
      assert ID.id(%{id: "id"}) == "id"
      assert ID.id(%{"id" => "id"}) == "id"
      assert ID.id(%{guid: "id"}) == "id"
      assert ID.id(%{"guid" => "id"}) == "id"
      assert ID.id(%{"not-an-id" => "id"}) == nil
      assert ID.id(%{id: "id", guid: "guid"}) == "id"
      assert ID.id(%{"id" => "id", guid: "guid"}) == "id"
      assert ID.id(%{"id" => "id", "guid" => "guid"}) == "id"
    end

    test "string" do
      assert ID.id("id") == "id"
      assert ID.id("here") == "here"
      assert ID.id(<<1>>) == <<1>>
    end

    test "atom" do
      assert ID.id(:foo) == :foo
      assert ID.id(Here.Is.A.Thing) == Here.Is.A.Thing
      assert ID.id(true) == true
      assert ID.id(false) == false
      assert ID.id(nil) == nil
    end

    test "number" do
      assert ID.id(123) == 123
      assert ID.id(1.23) == 1.23
      assert ID.id(0) == 0
    end

    test "pid" do
      assert ID.id(self()) == self()
    end

    test "struct" do
      assert ID.id(%IDStruct{token: "the-id"}) == "the-id"
      assert ID.id(%FullIDStruct{token: "the-id"}) == "the-id"
      assert ID.id(%{__struct__: UnknownIDStruct, unknown_id: "the-id"}) == "the-id"
      assert ID.id(%UnimplementedStruct{id: "the-id", guid: "the-guid"}) == "the-id"
    end
  end

  describe "guid/1" do
    test "map" do
      assert ID.guid(%{id: "id"}) == "id"
      assert ID.guid(%{"id" => "id"}) == "id"
      assert ID.guid(%{guid: "id"}) == "id"
      assert ID.guid(%{"guid" => "id"}) == "id"
      assert ID.guid(%{"not-an-id" => "id"}) == nil
      assert ID.guid(%{id: "id", guid: "guid"}) == "guid"
      assert ID.guid(%{"id" => "id", guid: "guid"}) == "guid"
      assert ID.guid(%{"id" => "id", "guid" => "guid"}) == "guid"
    end

    test "string" do
      assert ID.guid("id") == "id"
      assert ID.guid("here") == "here"
      assert ID.guid(<<1>>) == <<1>>
    end

    test "atom" do
      assert ID.guid(:foo) == :foo
      assert ID.guid(Here.Is.A.Thing) == Here.Is.A.Thing
      assert ID.guid(true) == true
      assert ID.guid(false) == false
      assert ID.guid(nil) == nil
    end

    test "number" do
      assert ID.guid(123) == 123
      assert ID.guid(1.23) == 1.23
      assert ID.guid(0) == 0
    end

    test "pid" do
      assert ID.guid(self()) == self()
    end

    test "struct" do
      assert ID.guid(%IDStruct{token: "the-id"}) == "the-id"
      assert ID.guid(%FullIDStruct{token: "the-id", the_guid: "the-guid"}) == "the-guid"
      assert ID.guid(%{__struct__: UnknownIDStruct, unknown_id: "the-id", unknown_guid: "guid"}) == "guid"
      assert ID.guid(%UnimplementedStruct{id: "the-id", guid: "the-guid"}) == "the-guid"
    end

  end
end
