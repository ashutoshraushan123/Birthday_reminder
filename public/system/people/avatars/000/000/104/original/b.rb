class CsvUploadsController < ApplicationController

  # POST /csv_uploads
  # POST /csv_uploads.json
  def create
    @campaign = current_user.campaigns.find(params[:campaign_id])
    csv = CsvUpload.new(params[:csv_file].try(:read), @campaign.id)

    if csv.save
      redirect_to campaign_steps_wizard_path(@campaign.id, :urls, edit_mode: "true")
    else
      flass_notification = if "Validation failed: Url BackLink's creation limit is over." == csv.error.to_s
        { notice: "BackLink's creation limit is over." }
      elsif "Validation failed: Campaign Url's creation limit is over." == csv.error.to_s
        { notice: "Url's creation limit is over." }
      else
        { alert: "<h4>These can be the possible errors uploading csv file.</h4> #{possible_errors}".html_safe }
      end

      redirect_to campaign_steps_wizard_path(@campaign.id, :urls, edit_mode: "true"), flass_notification
    end
  end

  protected
  def possible_errors
    "<ol>
      <li>Trying to upload without selecting any file</li>
      <li>File format is not .csv</li>
      <li>Uploaded .csv format does not match with the desired one</li>
      <li>Specified duplicate URLS or Backlinks</li>
      <li>Specified Backlink same as the URL</li>
      <li>URL Backlink creation limit is over</li>
    </ol>"
  end