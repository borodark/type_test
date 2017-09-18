defmodule TypeTest.Action do
# create table test(id bigserial PRIMARY KEY, unix_date integer not null default 0);
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, only: [from: 2]

  alias TypeTest.{Action,Repo}

  schema "actions" do
    field :a, :string, default: "a"
    field :unix_time, UnixDateTime
    timestamps()
  end

  def changeset(record, params \\ :empty) do
    record
    |> cast(params, [:a, :unix_time])
    |> validate_required([:a])
  end

  def add(a) do
    %Action{}
    |> Action.changeset(%{a: a})
    |> Repo.insert!
  end

  def add(a, t) do
    %Action{}
    |> Action.changeset(%{a: a, unix_time: t})
    |> Repo.insert!
  end

  def summary(a) do
    query = from t in Action,
      where: t.a == ^a,
      select: {t.a, t.unix_time}
    Repo.all(query)
  end
end
