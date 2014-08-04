class ContentsController < ApplicationController
    def show
        @content = Content.find_by_title(content_params[:title])
        if @content 
            render json: @content
        else
            head status: 400
        end
    end

    def create
        @content = Content.new(content_params)
        if @content.save
            render json: @content
        else 
            head status: 400
        end
    end

    def destroy
        @content = Content.find_by_title(content_params[:title])
        @content.destroy
        head ok
    end

    def index
        @content = Content.find_by_title(content_params[:title])
        if @content 
            render json: @content
        else
            head status: 400
        end
    end

    def update
        @content = Content.find_by_title(content_params[:title])
        if @content.update_attributes(content_params)
            render json: @content
        else
            render status: 400
        end
    end

    private

    def content_params
        params.require(:content).permit(:title, :body)
    end
end
