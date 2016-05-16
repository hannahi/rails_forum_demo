class RatingsController < ApplicationController

  before_action :set_rating, only: [:destroy]

  # GET /ratings
  def index
    @ratings = Rating.all
  end

  # POST /ratings
  def create
    @messages = Message.all
    @rating = Rating.new
    @rating.user_id = current_user.id
    @rating.message_id = params[:message_id]
    respond_to do |format|
      if @rating.save
        format.js   {}
      end
    end
  end

  # DELETE /ratings/1
  def destroy
    @messages = Message.all
    @rating.destroy
    respond_to do |format|
      format.js   {}
    end
  end

  private
    def set_rating
      @rating = Rating.find(params[:id])
    end

    def rating_params
      params.require(:rating).permit(:message_id, :user_id)
    end
end
