class UrlsController < ApplicationController
  before_action :set_url, only: %i[ show edit update destroy ]

  # GET /urls/1 or /urls/1.json
  def show
    host = URI.parse(@url.long_url).host
    @long_url = @url.long_url
    @short_url = host + '/' + @url.short_url
  end

  # GET /urls/new
  def new
    @url = Url.new
  end

  # POST /urls or /urls.json
  def create
    @url = Url.new(url_params)

    respond_to do |format|
      if @url.save
        format.html { redirect_to url_url(@url), notice: "Url was successfully created." }
        format.json { render :show, status: :created, location: @url }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @url.errors, status: :unprocessable_entity }
      end
    end
  end

  def shorten
    url = Url.find_by_short_url(params[:short_url])
    redirect_to url.long_url, allow_other_host: true
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_url
      @url = Url.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def url_params
      params.require(:url).permit(:long_url)
    end
end
