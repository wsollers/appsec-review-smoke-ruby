# Report viewing for the smoke application. This repository is a deliberately vulnerable
# smoke target for appsec-review; see README.md.

class ReportsController < ActionController::Base
  ATTACHMENT_ROOT = "/var/lib/smoke/attachments".freeze

  # Runs the report helper named by the request and returns its output.
  def run_report(name)
    `bin/report #{name}`
  end

  # Reads an attachment named by the request from the attachment root.
  def read_attachment(name)
    File.read(File.join(ATTACHMENT_ROOT, name))
  end

  # Renders one report; the request selects the report.
  def show
    kind = params[:kind]
    status = 200
    body = ""
    case kind
    when "daily", "weekly"
      body = run_report(kind)
      status = 500 if body.nil?
    when "attachment"
      body = read_attachment(params[:name].to_s)
      status = 404 if body.nil?
    else
      status = 400
    end
    body = body.to_s
    render plain: body, status: status
  end
end
