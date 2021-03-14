Benchee.run(%{
  "build"    => fn -> ReportsGenerator.build("report_complete.csv") end,
  "build_from_many" => fn -> ReportsGenerator.build_from_many(["report_1.csv", "report_2.csv", "report_3.csv"]) end
})
