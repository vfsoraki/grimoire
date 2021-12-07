# Grimoire

Superchared structs!

Say, there is this struct:

```elixir
defmodule User do
    defstruct [:first_name, :last_name]
end
```

And you need a function `full_name` to concatenate `first_name` and `last_name`.

You can define a function somewhere like:

```elixir
def full_name(user), do: "#{user.first_name} #{user.last_name}"
```

And use it:

```elixir
"Welcome #{full_name(user)}!"
```

OK, but we can do better.

`Grimoire` allows you to define:

```elixir
defmodule User do
    import Grimoire

    defstruct [:first_name, :last_name]

    grimoire do
        def full_name(user), do: "#{user.first_name} #{user.last_name}"
    end
end
```

And when you need `full_name`:

```elixir
import Grimoire

"Welcome #{user~>fullname}!"
```

You can also define:

```elixir
grimoire do
    def full_name(user), do: "#{user.first_name} #{user.last_name}"
    def full_name(user, :upcase), do: user |> full_name() |> String.upcase()
end
```

And use:

```elixir
import Grimoire

"Welcome #{user~>full_name(:upcase)}!"
```

Basically, `Grimoire` allows you to _attach_ some functions to your structs.

`Ecto` schemas are structs too! You can supercharge them like any other struct:

```elixir
defmodule User do
    use Ecto.Schema
    import Grimoire

    schema "users" do
        field :first_name, :string
        field :last_name, :string
    end

    grimoire do
        def full_name(user), do: "#{user.first_name} #{user.last_name}"
        def full_name(user, :upcase), do: user |> full_name() |> String.upcase()
    end
end

# Usage
import Grimoire

"Welcome #{user~>full_name(:upcase)}!"
```

You can think of this as _computed fields_ too.


## Installation

This package is not available in Hex, so you might want to add it from git.
I plan to publish it on Hex soon.

```elixir
{:grimoire, git: "https://github.com/vfsoraki/grimoire"}
```
