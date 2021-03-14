defmodule ReportsGeneratorTest do
  use ExUnit.Case

  describe "build/1" do
    test "when a file name is provided, builds the report" do
      file_name = "report_test.csv"

      response =
        file_name
        |> ReportsGenerator.build()

      expected_response = {
        :ok,
        %{
          "foods" => %{
            "açaí" => 1,
            "churrasco" => 2,
            "esfirra" => 3,
            "hambúrguer" => 2,
            "pastel" => 0,
            "pizza" => 2,
            "prato_feito" => 0,
            "sushi" => 0
          },
          "users" => %{
            "1" => 48,
            "10" => 36,
            "11" => 0,
            "12" => 0,
            "13" => 0,
            "14" => 0,
            "15" => 0,
            "16" => 0,
            "17" => 0,
            "18" => 0,
            "19" => 0,
            "2" => 45,
            "20" => 0,
            "21" => 0,
            "22" => 0,
            "23" => 0,
            "24" => 0,
            "25" => 0,
            "26" => 0,
            "27" => 0,
            "28" => 0,
            "29" => 0,
            "3" => 31,
            "30" => 0,
            "4" => 42,
            "5" => 49,
            "6" => 18,
            "7" => 27,
            "8" => 25,
            "9" => 24
          }
        }
      }

      assert expected_response == response
    end

    test "when an invalid file name is provided, returns an error" do
      response = ReportsGenerator.build("")

      expected_response = {:error, "Invalid file name"}

      assert expected_response == response
    end
  end

  describe "build_from_many/1" do
    test "when a file name list is provided, builds the report" do
      file_names = ["report_test.csv", "report_test.csv"]

      response =
        file_names
        |> ReportsGenerator.build_from_many()

      expected_response = {
        :ok,
        %{
          "foods" => %{
            "açaí" => 2,
            "churrasco" => 4,
            "esfirra" => 6,
            "hambúrguer" => 4,
            "pastel" => 0,
            "pizza" => 4,
            "prato_feito" => 0,
            "sushi" => 0
          },
          "users" => %{
            "1" => 96,
            "10" => 72,
            "11" => 0,
            "12" => 0,
            "13" => 0,
            "14" => 0,
            "15" => 0,
            "16" => 0,
            "17" => 0,
            "18" => 0,
            "19" => 0,
            "2" => 90,
            "20" => 0,
            "21" => 0,
            "22" => 0,
            "23" => 0,
            "24" => 0,
            "25" => 0,
            "26" => 0,
            "27" => 0,
            "28" => 0,
            "29" => 0,
            "3" => 62,
            "30" => 0,
            "4" => 84,
            "5" => 98,
            "6" => 36,
            "7" => 54,
            "8" => 50,
            "9" => 48
          }
        }
      }

      assert expected_response == response
    end

    test "when an invalid file name list is provided, returns an error" do
      response = ReportsGenerator.build_from_many("anything")

      expected_response = {:error, "Invalid file names, please provide a list of strings"}

      assert expected_response == response
    end
  end

  describe "fetch_higher_cost/2" do
    test "when the option is \"users\", returns the user who spend the most" do
      file_name = "report_test.csv"
      option = "users"

      response =
        file_name
        |> ReportsGenerator.build()
        |> ReportsGenerator.fetch_higher_cost(option)

      expected_response = {:ok, {"5", 49}}

      assert expected_response == response
    end

    test "when the option is \"foods\", returns the most consumed food" do
      file_name = "report_test.csv"
      option = "foods"

      response =
        file_name
        |> ReportsGenerator.build()
        |> ReportsGenerator.fetch_higher_cost(option)

      expected_response = {:ok, {"esfirra", 3}}

      assert expected_response == response
    end

    test "when an invalid option is given, returns an error" do
      file_name = "report_test.csv"
      option = "other"

      response =
        file_name
        |> ReportsGenerator.build()
        |> ReportsGenerator.fetch_higher_cost(option)

      expected_response = {:error, "Invalid option"}

      assert expected_response == response
    end
  end
end
