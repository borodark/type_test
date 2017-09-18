use Mix.Config

config :type_test, TypeTest.Repo, [
  adapter: Ecto.Adapters.Postgres,
  database: "type_test_#{Mix.env}",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
]
