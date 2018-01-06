class QuotesController < ApplicationController
  respond_to :json
  before_action :ensure_create_params, only: :create

  def show
    quote = Quote.find_by(id: params[:id])
    if quote
      render json: quote.to_json
    else
      render json: { error: 'No quote found' }, status: 404
    end
  end

  def create
    quote = Quote.new(quote_params)
    if quote.save
      render json: quote.to_json
    else
      render json: { error: quote.errors  }, status: :unprocessable_entity
    end
  end

  def random
    quote = Quote.order('RANDOM()').limit(1).first
    # byebug
    render json: quote.to_json
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

    def ensure_create_params
      quote_params.require([:category, :topic])
    end
end