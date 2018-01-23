defmodule CliTest do
  use ExUnit.Case

  doctest Issues

  import Issues.CLI, only: [parse_args: 1, sort_into_ascending_order: 1]

  test ":help returned when passing -h or --help options" do
    assert parse_args(["-h", "asdasda"]) == :help
    assert parse_args(["--help", "asdasda"]) == :help
  end

  test "3 values returned if 3 given" do
    assert parse_args(["user", "project", "99"]) == {"user", "project", 99}
  end

  test "default 3rd value given if 2 given" do
    assert parse_args(["user", "project"]) == {"user", "project", 4}
  end

  test "sort_into_ascending_order works correctly" do
    result = fake_created_at_list(["a", "b", "c"]) |> sort_into_ascending_order
    issues = for issue <- result, do: Map.get(issue, "created_at")
    assert issues == ~w{a b c}
  end

  def fake_created_at_list(list) do
    Enum.map(list, fn(a) -> %{"created_at" => a, "other_value" => "xxx"} end)
  end
end
