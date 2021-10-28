# frozen_string_literal: true

# Controller manages uploading and displaying CSVs
class FileUploadsController < ApplicationController
  # The second value for each category entry will be used to determine the
  # job class that processes the data.
  #
  # Ex: Selecting "Measurement" in the form will post "Measurement"
  # and process the data with a MeasurementJob.
  FILE_UPLOAD_CATEGORIES = CsvImporter::CATEGORIES.map do |category|
    [category, category.delete(' ')]
  end.freeze

  def index
    @pagy, @processed_files = pagy(ProcessedFile.all.order(updated_at: :desc))
  end

  def csv_index
    @pagy, @file_uploads = pagy(FileUpload.for_organization(current_organization).order(created_at: :desc))
  end

  def new
    @categories = [['Select One', '']] + FILE_UPLOAD_CATEGORIES
  end

  def show
    @processed_file = ProcessedFile.find(params[:id])
    record_class = @processed_file.category.constantize
    @headers = record_class::HEADERS.keys.map(&:downcase)
    @records = record_class.where(processed_file_id: @processed_file.id)

    respond_to do |format|
      format.html
      format.csv { send_data @processed_file.temporary_file.contents, filename: @processed_file.filename }
    end
  end

  def upload
    @file_uploads = []

    input_files.each do |input_file|
      @file_uploads << FileUploader.new(
        category: params[:category],
        input_file: input_file,
        organization: current_organization
      ).process
    end
  rescue NoMethodError
    head :bad_request
  end

  def destroy
    processed_file = ProcessedFile.find(params[:id])
    if processed_file.destroy
      redirect_to file_uploads_path, notice: 'File successfully deleted'
    else
      redirect_to file_uploads_path, alert: 'There was an issue deleting this file upload'
    end
  end

  private

  def input_files
    params[:input_files]
  end
end
