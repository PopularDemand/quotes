class QuotesController < ApplicationController
  respond_to :json

  def show
    quote = Quote.find_by(id: params[:id])
    if quote
      render json: quote
    else
      render json: { error: 'No quote found' }, status: 404
    end
  end

  def create
    quote = Quote.new(quote_params)
    if quote.save
      render quote
    else
      render json: { error: quote.errors  }, status: :unprocessable_entity
    end
  end

  private

    def quote_params
      params.require(:quote).permit(
        :id,
        :content,
        :attribution,
        :category, 
        :topic
      )
    end
end