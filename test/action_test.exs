defmodule TypeTest.ActionTest do
  use ExUnit.Case, async: true

  alias TypeTest.{Action, Repo}
  doctest TypeTest.Action

  setup do
    # Explicitly get a connection before each test
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end

  test "Return an empty summary" do
    assert [] == Action.summary("a")
  end

  test "Add actions and then get timestamps correctly" do
    assert [] == Action.summary("a")

    Action.add("a")
    Action.add("a")
    assert [{"a", nil},{"a", nil}] == Action.summary("a")

    Action.add("b", DateTime.from_unix!(0))
    # this timestamp is equivalent to nil: idiosyncrasies
    Action.add("b", DateTime.from_unix!(1))
    Action.add("b", DateTime.from_unix!(2))
    Action.add("b", DateTime.from_unix!(3))
    Action.add("b")
    # this timestamp is equivalent to nil
    assert [
      {"b", nil}, # expecting timestamp being nil for the first ...
      {"b", DateTime.from_unix!(1)},
      {"b", DateTime.from_unix!(2)},
      {"b", DateTime.from_unix!(3)},
      {"b", nil} # and last entities
    ] == Action.summary("b")

  end
end
