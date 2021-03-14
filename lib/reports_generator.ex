defmodule ReportsGenerator do
  alias ReportsGenerator.Parser

  @available_foods [
    "açaí",
    "churrasco",
    "esfirra",
    "hambúrguer",
    "pastel",
    "pizza",
    "prato_feito",
    "sushi"
  ]

  @options [
    "foods",
    "users"
  ]

  def build(file_name) when not is_bitstring(file_name) or file_name == "" do
    {:error, "Invalid file name"}
  end

  def build(file_name) do
    result =
      file_name
      |> Parser.parse_file()
      |> Enum.reduce(reports_acc(), fn list, report -> sum_values(list, report) end)

    {:ok, result}
  end

  def build_from_many(file_names) when not is_list(file_names) do
    {:error, "Invalid file names, please provide a list of strings"}
  end

  def build_from_many(file_names) do
    result =
      file_names
      |> Task.async_stream(&build/1)
      |> Enum.reduce(
        reports_acc(),
        fn {:ok, result}, report -> sum_reports(report, result) end
      )

    {:ok, result}
  end

  def fetch_higher_cost({:ok, report}, option) when option in @options do
    {:ok, Enum.max_by(report[option], fn {_key, value} -> value end)}
  end

  def fetch_higher_cost(_report, _option), do: {:error, "Invalid option"}

  defp sum_values([id, food_name, price], %{"foods" => foods, "users" => users}) do
    users = Map.put(users, id, users[id] + price)
    foods = Map.put(foods, food_name, foods[food_name] + 1)

    build_report(users, foods)
  end

  defp sum_reports(
         %{"foods" => foods_one, "users" => users_one},
         {:ok, %{"foods" => foods_two, "users" => users_two}}
       ) do
    foods = merge_map(foods_one, foods_two)
    users = merge_map(users_one, users_two)

    build_report(users, foods)
  end

  defp merge_map(map_one, map_two) do
    Map.merge(map_one, map_two, fn _key, value_one, value_two -> value_one + value_two end)
  end

  defp reports_acc do
    foods = Enum.into(@available_foods, %{}, &{&1, 0})
    users = Enum.into(1..30, %{}, &{Integer.to_string(&1), 0})

    build_report(users, foods)
  end

  defp build_report(users, foods), do: %{"users" => users, "foods" => foods}
end
