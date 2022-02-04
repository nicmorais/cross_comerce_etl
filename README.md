# CrossComerceEtl - Nicolas Morais Santos
Instructions:
1. Install dependencies with `mix deps.get`
2. Create and migrate your database with `mix ecto.setup`
3. Run `iex -S mix`, type in `alias CrossComerceEtl.ExtractTransform`. Hit enter.
4. Now start the ETL task by running `ExtractTransform.run`

Once ExtractTransform.run have finished, you can visit http://localhost:4000/api/numbers from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
