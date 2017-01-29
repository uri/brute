# Brute

#### [Documentation](https://hexdocs.pm/brute)

Brute is a package that generates
[combinations](https://en.wikipedia.org/wiki/Combination) of various
characters.

For example, Brute can generate the combinations for the set `{a b c}`:

```elixir
Brute.generic(?a..?c, 1..3)
```

Will generate something similar to the following: a, b , c, ..., z, aa, ab,
..., zy, zz, ... aaa, aab, ..., zzy, zzz.

**There is no order guarantee within set-length**.


Since most functions in `Brute` return a stream, they can combined with other
operations. For example, calculating a hash:

```elixir
'abcdefghijkpqrstuvwxyzABCDEFGHIJKPQRSTUVWXYZ0123456789`~!@#$%^&*()_+{}:<>?"\'`'
|> Brute.generic(1..20)
|> Stream.map(fn str ->
  :crypto.hash(:sha, str) |> Base.encode16
end)
```

## Installation

```elixir
def deps do
  [{:brute, "~> 0.1.0"}]
end
```

If you are using Elixir 1.3 or lower you will also need to add `brute` to your applications.

```elixir
def application do
  [ ... applications: [ ..., :brute ] ]
end
```

## TODO

- [ ] Benchmarks
- [ ] Caching combinations
