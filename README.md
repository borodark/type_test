# Demo project for ecto type patch with optional callback handles_nil?
https://github.com/borodark/ecto/tree/feature/dump_nil

# Why change ecto this way?
I had to work with a legacy database lately and among many idiosyncrasies of database design encountered one was difficult to dodge. The timestamp column stores time as value of seconds starting from 1970-01-01 00:00:00.
It is declared of type integer as following
'''
CREATE TABLE actions (
    id bigint NOT NULL,
    a character varying(255) DEFAULT 'a'::character varying,
    unix_time integer DEFAULT 0 );
'''

While `0`` represents a valid date it's still the same as being `nil`.

The Ecto does not treat `nil` differently for any type of its own or custom types.
The `dump/1` always produces `{:ok, nil}`.

The change allows custom type implementations to load, dump and cast all values including 
any value of column producing `nil` in the structure field.
