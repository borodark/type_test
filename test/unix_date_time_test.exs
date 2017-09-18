defmodule Ecto.UnixDateTimeTest do

  use ExUnit.Case, async: true

  @test_0 0
  @test_nil nil
  @test_date_0 DateTime.from_unix!(0)
  @test_date_120 DateTime.from_unix!(120)

  test "cast" do
    assert UnixDateTime.cast(@test_date_120) == {:ok, @test_date_120}
    assert UnixDateTime.cast(@test_date_0) == {:ok, @test_date_0}
    assert UnixDateTime.cast(@test_nil) == :error
    assert UnixDateTime.cast(@test_0) == :error
  end

  test "load" do
    assert UnixDateTime.load(120) == {:ok, @test_date_120}
    assert UnixDateTime.load(0) == {:ok, nil}
    assert UnixDateTime.load("") == :error
    assert UnixDateTime.load(nil) == :error
  end

  test "dump" do
    assert UnixDateTime.dump(@test_date_120) =={:ok, 120}
    assert UnixDateTime.dump(@test_date_0) == {:ok, 0}
    assert UnixDateTime.dump(@test_nil) == {:ok, 0}
    assert UnixDateTime.dump(@test_0) == :error
  end

end
