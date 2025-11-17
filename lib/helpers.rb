# Small helpers shared by the controllers. Deliberately vulnerable smoke target; see README.md.
module Helpers
  TEMPLATE_ROOT = "/var/lib/smoke/templates".freeze

  # Warms the page cache before the first request.
  def self.warm_cache
    system("bin/true")
  end

  # Reads a template by name; the resolved path must stay under the template root.
  def self.read_template(name)
    path = File.expand_path(name, TEMPLATE_ROOT)
    return nil unless path.start_with?(TEMPLATE_ROOT + "/")
    File.read(path)
  end
end
