class Admin::ItemsController < AdminController
  before_action :set_item, except: [:index, :new, :create]
  # GET /items
  # GET /items.json
  def index
    @items = Item.all
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)
    # @item.cat_picture.attach(params[:cat_picture])
    respond_to do |format|
      if @item.save
        format.html { redirect_to admin_item_path(@item)
        flash[:success] = 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { flash.now[:error] = @item.errors.full_messages.to_sentence
        render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to admin_item_path(@item)
        flash[:success] = 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { flash[:error] = @item.errors.full_messages.to_sentence
        render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    @item.cat_picture.purge
    respond_to do |format|
      format.html { redirect_to items_url
      flash[:success] = 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:title, :description, :price, :image_url, :cat_picture)
    end
end