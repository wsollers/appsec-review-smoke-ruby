# appsec-review-smoke-ruby

A deliberately vulnerable **smoke target** for [appsec-review](https://github.com/wsollers/appsec-review).
It exists so that a review of a tiny, fully understood Ruby program has one correct answer at
every stage. **Do not deploy, run against untrusted input, or reuse any of this code.**

The program is a toy Rails-style application: `ReportsController` renders reports selected by
the request; `lib/synthetic.rb` is the code-graph fixture program.

## Build

One Bundler manifest (`Gemfile`, `Gemfile.lock`), no network, no generated code. The nominal
build is a syntax check over the sources:

```sh
ruby -c lib/*.rb
```

appsec-review has no Ruby build profile and none of its catalog images carries a Ruby
interpreter, so this target has no pinned image in which to prove an offline build; the syntax
check above is the nominal build command and was not executed by the Stage 3 verification. The
gap is recorded in appsec-review `docs/TODO.md` (T-139). The dependency, scanner, history and
complexity checks do not need Ruby and were run.

## History

`tools/make-history.sh` rebuilds this repository's commit graph from `tools/history/steps/` with
fixed authors and dates, so the history is reproducible and can be reviewed as code.

## License

MIT; see `LICENSE`.
