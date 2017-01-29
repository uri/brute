defmodule Brute do
  @moduledoc """
  Brute is a package that generates combinations of various characters.

  For example, Brute can generate all of the combinations of the characters a b
  c using the following:

      Brute.generic(?a..?c, 3)

  Will generate aaa, aac, ... , ccb, ccc (no order gurantee).

  By providing a range, brute will generate all combinations from the specified
  lengths.

      Brute.generic(?a..?c, 1..3)

  Will generate something similar to the following: a, b , c, ..., z, aa, ab,
  ..., zy, zz, ... aaa, aab, ..., zzy, zzz

  Since most functions in `Brute` return a stream, they can combined with other
  operations. For example, calculating a hash:

      'abcdefghijkpqrstuvwxyzABCDEFGHIJKPQRSTUVWXYZ0123456789`~!@#$%^&*()_+{}:"<>?"`'
      |> Brute.generic(1..20)
      |> Stream.map(fn str ->
        :crypto.hash(:sha, str) |> Base.encode16
      end)
  """

  @doc """
  Generates combinations for abcdefghijklmnopqrstuvwxyz specifined by `n`.
      iex> Brute.alpha(1) |> Enum.to_list |> length
      26
  """
  @spec alpha(pos_integer) :: Stream.t
  def alpha(n) when n > 0 do
    generic(?a..?z, n)
  end

  @doc """
  Generates combinations for any specified charlist with length of `depth`.

      iex> set = Brute.generic(?a..?c, 3)
      iex> "aca" in set
      true

      iex> set = Brute.generic(?0..?9, 3) |> Enum.to_list
      iex> length(set)
      100
      iex> "999" in set
      true
      iex> "737" in set
      true
  """
  @spec generic(charlist, 1) :: Stream.t
  def generic(characters, 1) do
    Enum.map(characters, fn char ->
      char
      |> List.wrap
      |> to_string
    end)
  end

  @doc """
  Returns a stream of character combinations of length `low` to `high`, by specifying low = 1, high = 3 with the character set of a b c the following stream will be returned:

  a, b , c, ..., z, aa, ab, ..., zy, zz, ... aaa, aab, ..., zzy, zzz
  """
  @spec generic(charlist, Range.t) :: Stream.t
  def generic(characters, low..high = range) when low > 0 and high > 0 do
    Stream.flat_map(range, fn depth ->
      generic(characters, depth)
    end)
  end
  @spec generic(charlist, pos_integer) :: Stream.t
  def generic(characters, depth) do
    base = generic(characters, 1)
    next = generic(characters, depth - 1)
    Stream.flat_map(base, fn seq ->
      Stream.map(next, fn inner ->
        inner <> seq
      end)
    end)
  end
end
