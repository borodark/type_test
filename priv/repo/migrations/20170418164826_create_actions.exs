defmodule TypeTest.Repo.Migrations.CreateActions do
  use Ecto.Migration
  # CREATE TABLE test (  id bigserial , unix_date integer DEFAULT 0 NOT NULL
  def change do
    create table(:actions) do
     add :a, :string, default: "a"
     add :unix_time, :integer, default: 0
     timestamps()
    end
  end
end
