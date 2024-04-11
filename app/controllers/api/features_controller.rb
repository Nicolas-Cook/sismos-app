module Api
  class FeaturesController < ApplicationController
    # GET /features
    def index
      if params[:mag_type]
        mag_types = params[:mag_type].split(',')
        features = Feature.all.select do |feature|
          mag_types.include? feature.data['attributes']['mag_type']
        end
      else
        features = Feature.all
      end
      
      per_page = params[:per_page].to_i
      per_page = [per_page, 1000].min
      
      features = features.slice((params[:page].to_i - 1) * per_page, per_page)
      render json: features.map { |feature| {"data" => {"id" => feature.id}.merge(feature.data)} }
    end
    # POST /features/:id/comments
    def create
      feature_id = params[:feature_id].to_i
      Rails.logger.debug "Feature ID: #{feature_id}"
      feature = Feature.find(params[:feature_id])
      comment = feature.comments.create(comment_params)
      if comment.save
        render json: comment, status: :created
      else
        render json: comment.errors, status: :unprocessable_entity
      end
    end

    private

    def comment_params
      params.require(:comment).permit(:body)
    end
  end
end
