# appsec-review-smoke-ruby

A deliberately vulnerable **smoke target** for [appsec-review](https://github.com/wsollers/appsec-review).
It exists so that a review of a tiny, fully understood Ruby program has one correct answer at
every stage. **Do not deploy, run against untrusted input, or reuse any of this code.**

The program is a toy Rails-style application: `ReportsController` renders reports selected by
the request; `lib/synthetic.rb` is the code-graph fixture program.

## License

MIT; see `LICENSE`.
