class JoinTableCartsItemsController < ApplicationController
  include CurrentCart
  before_action :set_joint_table_carts_item, only: [:show, :edit, :update, :destroy]
  before_action :set_cart, only: [:create]
  before_action :authenticate_user!

  # GET /join_table_carts_items
  # GET /join_table_carts_items.json
  def index
    @join_table_carts_items = JoinTableCartsItem.all
  end

  # GET /join_table_carts_items/1
  # GET /join_table_carts_items/1.json
  def show
  end

  # GET /join_table_carts_items/new
  def new
    @joint_table_carts_item = JoinTableCartsItem.new
  end

  # GET /join_table_carts_items/1/edit
  def edit
  end

  # POST /join_table_carts_items
  # POST /join_table_carts_items.json
  def create
    @item = Item.find(params[:item_id])
    @joint_table_carts_item = current_user.cart.add_item(@item)

    respond_to do |format|
      if @joint_table_carts_item.save
        format.html { redirect_to @joint_table_carts_item.cart, notice: 'Item added to cart.' }
        format.json { render :show, status: :created, location: @joint_table_carts_item }
      else
        format.html { render :new }
        format.json { render json: @joint_table_carts_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /join_table_carts_items/1
  # PATCH/PUT /join_table_carts_items/1.json
  def update
    respond_to do |format|
      if @joint_table_carts_item.update(joint_table_carts_item_params)
        format.html { redirect_to @joint_table_carts_item, notice: 'Join items order was successfully updated.' }
        format.json { render :show, status: :ok, location: @joint_table_carts_item }
      else
        format.html { render :edit }
        format.json { render json: @joint_table_carts_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /join_table_carts_items/1
  # DELETE /join_table_carts_items/1.json
  def destroy
    @cart = Card.find(session[:cart_id])
    @joint_table_carts_item.destroy
    respond_to do |format|
      format.html { redirect_to cart_path(@cart), notice: 'Join items order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_joint_table_carts_item
      @joint_table_carts_item = JoinTableCartsItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def joint_table_carts_item_params
      params.require(:joint_table_carts_item).permit(:item_id)
    end
end

