# Entry point of the smoke application: loads the controllers and the fixture program.
# This repository is a deliberately vulnerable smoke target for appsec-review; see README.md.

require_relative "reports_controller"
require_relative "synthetic"
