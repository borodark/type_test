defmodule UnixDateTime do
  @moduledoc """
  An Ecto type for Date Time stored in DB as integer produced by unix `date +%s` command
  The DB column declared as 'NOT NULL DEFAULT 0'
  The use of 0 instead nil is lame because `date +%s` returns 0 for 1970-01-01 00:00:00
  and negative values represent number of seconds prior to that date
  Unfortunately some legacy databases can not be changed but we want to use Ecto with these systems. 
  """
  @behaviour Ecto.Type

  @spec handles_nil?() :: boolean
  def handles_nil?(), do: true

  @doc """
  The Ecto type.
  """
  def type, do: __MODULE__

  @typedoc """
  A %DateTime{}.
  """
  @type t :: %DateTime{}

  @doc """
  Casts to __MODULE__.
  """
  @spec cast(t | any) :: {:ok, t} | :error
  def cast(%DateTime{} = date), do: {:ok, date}

  def cast(_), do: :error

  @doc """
  Converts a DateTime into an integer
  """
  @spec dump(t | any) :: {:ok, integer} | :error
  # Write 0 for no value
  def dump(nil), do: {:ok, 0}
  # Write integer for any valid date
  def dump(%DateTime{} = date), do: {:ok, DateTime.to_unix(date)}

  def dump(_), do: :error

  @doc """
  Converts an integer: into DateTime.
  """
  @spec load(integer) :: {:ok, t} | :error
  # If DB contains 0 this means Date has a default value and it's blank
  def load(0), do: {:ok, nil}

  def load(value) when is_integer(value) do
    {:ok, DateTime.from_unix!(value)}
  end

  def load(_), do: :error

end
