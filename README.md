# 408 Trailblazer Timeout

## Running tests (Minitest)

In my `~/.bashrc` I add the following line for the `$ t ...` alias.

```sh
alias t="bundle exec ruby -Itest "
```

This allows to run a test by invoking the command below on the terminal.

```
$ t test/concepts/blog_post/operation_test.rb
```

