# Trailblazer Guides

We're developing a simple CRUD application to write blog posts.

## Gems

This guide shows you how to use trailblazer-operation.

This version does not use Cells, but normal Rails views to render the HTML views.

## Files we didn't discuss

* **Layout** We use a default layout template in `app/views/layouts/application.html.erb` which the controller uses automatically: https://guides.rubyonrails.org/layouts_and_rendering.html#finding-layouts
* **Initializer** `config/initializers/trailblazer.rb` requires `reform` and `dry/validation`.

## TODO

[] Show how `"contract.default"` can be aliased to `:contract`.
[] Rewrite views using Cells
