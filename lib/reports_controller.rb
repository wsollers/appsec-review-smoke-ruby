# Report viewing for the smoke application. This repository is a deliberately vulnerable
# smoke target for appsec-review; see README.md.

class ReportsController < ActionController::Base

  # Renders one report; the request selects the report.
  def show
    kind = params[:kind]
    status = 200
    body = ""
    case kind
    when "daily", "weekly"
      body = "#{kind} report"
    else
      status = 400
    end
    body = body.to_s
    render plain: body, status: status
  end
end
