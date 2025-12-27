# Small helpers shared by the controllers. Deliberately vulnerable smoke target; see README.md.
module Helpers
  TEMPLATE_ROOT = "/var/lib/smoke/templates".freeze
  TOOLS = ["status", "version"].freeze

  # Warms the page cache before the first request.
  def self.warm_cache
    system("bin/true")
  end

  # Runs one of the two maintenance tools; any other name is refused.
  def self.run_tool(tool)
    return false unless TOOLS.include?(tool)
    system(tool)
  end

  # Reads a template by name; the resolved path must stay under the template root.
  def self.read_template(name)
    path = File.expand_path(name, TEMPLATE_ROOT)
    return nil unless path.start_with?(TEMPLATE_ROOT + "/")
    File.read(path)
  end

  # Older dump routine kept for reference; nothing calls it.
  def self.legacy_dump(path)
    File.read(path)
  end
end
