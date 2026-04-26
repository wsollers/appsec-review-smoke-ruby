# Report viewing for the smoke application. This repository is a deliberately vulnerable
# smoke target for appsec-review; see README.md.
require "json"

require_relative "helpers"

class ReportsController < ActionController::Base
  ATTACHMENT_ROOT = "/var/lib/smoke/attachments".freeze
  REPORTS = { "daily" => "daily summary", "weekly" => "weekly summary" }.freeze

  # Returns the recorded summary of one of the two reports; any other name yields nil.
  def run_report(name)
    REPORTS[name]
  end

  # Reads an attachment named by the request; the name is reduced to its base name first,
  # so the file opened is always directly under the attachment root.
  def read_attachment(name)
    File.read(File.join(ATTACHMENT_ROOT, File.basename(name)))
  end

  # Renders one report; the request selects the report, its format, filters and paging.
  def show
    kind = params[:kind]
    format = params[:format] || "text"
    page = params[:page].to_i
    status = 200
    body = ""
    case kind
    when "daily", "weekly"
      body = run_report(kind)
      status = 500 if body.nil?
    when "attachment"
      body = read_attachment(params[:name].to_s)
      status = 404 if body.nil?
    when "template"
      body = Helpers.read_template(params[:name].to_s)
      status = 404 if body.nil?
    when "tool"
      status = Helpers.run_tool(params[:tool].to_s) ? 200 : 400
    when "stats"
      body = "requests #{Helpers.requests}"
    else
      status = 400
    end
    body = body.to_s
    if status == 200 && params[:filter] && !params[:filter].empty?
      body = body.include?(params[:filter]) ? body : ""
    end
    if format == "json"
      body = { "body" => body, "page" => page }.to_json
    elsif format == "html"
      body = "<pre>#{body}</pre>"
    end
    Rails.logger.info("report #{kind} viewed by #{params[:user]}")
    Helpers.count! if status >= 200 && status < 300
    render plain: body, status: status
  end
end
