# Export download flow for the smoke application. Deliberately vulnerable smoke target; see README.md.
class ExportsController < ActionController::Base
  EXPORT_ROOT = "/var/lib/smoke/exports".freeze

  # Lists the finished exports.
  def index
    render plain: Dir.children(EXPORT_ROOT).sort.join("\n")
  end

  # Marks an export as collected and returns the client to the page it came from.
  def done
    Rails.cache.delete(params[:id].to_s)
    redirect_to params[:return_to]
  end
end
