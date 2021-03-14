# ReportsGenerator

[![Language](https://img.shields.io/badge/language-elixir-purple)](https://img.shields.io/badge/language-elixir-purple) [![License](https://img.shields.io/badge/license-MIT-lightgrey)](/LICENSE)

Repository for my Reports Generator project of the Elixir's path from [Rocketseat Ignite](https://rocketseat.com.br).

## :rocket: Techs

* [Elixir](https://elixir-lang.org/)

## :wrench: Setup

  * Install dependencies with `mix deps.get`
  * For interactive testing use `iex -S mix`

## :white_check_mark: Test

To run tests:

* Run with `mix test --cover`

## :zap: Benchmarking

To compare performance using Erlang Timer module:

* Run simple version `:timer.tc(fn -> ReportsGenerator.build("report_complete.csv") end)`
* Run parallel version `:timer.tc(fn ->  ReportsGenerator.build_from_many(["report_1.csv", "report_2.csv", "report_3.csv"]) end)`

To compare performance using [Benchee](https://github.com/bencheeorg/benchee):

* Run `mix run benchmark.exs`

## :page_facing_up: License

* [MIT](/LICENSE.txt)
