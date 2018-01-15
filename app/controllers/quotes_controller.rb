class QuotesController < ApplicationController
  respond_to :json
  before_action :ensure_create_params, only: [:create, :update]
  before_action :authenticate_secret_key, only: [:create, :update]

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

  def update
    quote = Quote.find_by(id: params[:id])
    params = Quote.convert_association_strings(quote_params)
    if quote.update_attributes(params)
      render json: quote.to_json
    else
      render json: { error: quote.errors  }, status: :unprocessable_entity
    end
  end

  def random
    quote = Quote.order('RANDOM()').limit(1).first
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

    def authenticate_secret_key
      if params[:secretKey] != ENV['SECRET_KEY']
        render json: { error: 'You are not authorized'  }, status: :unauthorized
      end
    end
end