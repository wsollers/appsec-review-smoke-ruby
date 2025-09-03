# Small helpers shared by the controllers. Deliberately vulnerable smoke target; see README.md.
module Helpers
  # Warms the page cache before the first request.
  def self.warm_cache
    system("bin/true")
  end
end
