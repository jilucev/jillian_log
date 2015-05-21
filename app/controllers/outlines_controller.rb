class OutlinesController < ApplicationController
  def index
    @outlines = current_user.outlines.page(params[:page])
  end

  def new
    @outline = Outline.new
  end

  def create
    @outline = current_user.outlines.build(outline_params)

    # @outline = Outline.new(outline_params)
    if @outline.save
      redirect_to :root
    else
      render 'outlines/index'
    end
  end

  def edit
    @outline = Outline.find(params[:id])
  end

  def show
    @outline = Outline.find(params[:id])
    @created = (@outline.created_at).strftime("%B %d, %Y")
    @created_time = (@outline.created_at).strftime("%H:%M")
    # @created = (@outline.created_at).to_formatted_s(:long_ordinal)
  end

  def update
    @outline = Outline.find(params[:id])

    if @outline.update(outline_params)
      redirect_to @outline
    else
      render 'edit'
    end
  end

  def destroy
    @outline = Outline.find(params[:id])
    @outline.destroy
    flash[:notice] = "outline deleted"
    redirect_to outlines_path
  end

  private

  def outline_params
    params.require(:outline).permit(:id, :title, :log)
  end
end
