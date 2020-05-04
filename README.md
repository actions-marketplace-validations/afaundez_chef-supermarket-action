# Chef Supermarket Action

Shares cookbook on the public supermarket.

## Workflow example

```yaml
name: delivery
on:
  release:
    types: [published]

jobs:
  delivery:
    runs-on: ubuntu-latest

    steps:
      - name: Check out code
        uses: actions/checkout@master
      - name: Run Chef Supermarket Share
        uses: afaundez/chef-supermarket@master
        with:
          cookbook: <the cookbook name>
          category: <the category>
          user: <the supermarket username>
          user: ${{ secrets.supermarketKey }}
```
