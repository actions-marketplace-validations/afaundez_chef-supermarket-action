# Chef Supermarket Action

Shares cookbook on the public supermarket.

## Workflow example

```yaml
name: chef supermaket
on:
  release:
    types: [published]

jobs:
  share:
    runs-on: ubuntu-latest

    steps:
      - name: Check out code
        uses: actions/checkout@master
      - name: Run Chef Supermarket Share
        uses: afaundez/chef-supermarket-action@master
        with:
          cookbook: <the cookbook name>
          category: <the category>
          user: <the supermarket username>
          key: ${{ secrets.supermarketKey }}
```
