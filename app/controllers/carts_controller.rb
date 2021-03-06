class CartsController < ApplicationController
  include CurrentCart
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart 
  before_action :set_cart, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :redirect_to_root, if: :not_current_user_cart?

  # GET /carts/1
  # GET /carts/1.json
  def show
  end

  # GET /carts/1/edit
  def edit
  end

  # POST /carts
  # POST /carts.json
  def create
    @cart = Cart.new(cart_params)
    @cart.user = current_user

    respond_to do |format|
      if @cart.save
        format.html { redirect_to @cart
        flash[:success] = 'Cart was successfully created.' }
        format.json { render :show, status: :created, location: @cart }
      else
        format.html { flash.now[:error] = @cart.errors.full_messages.to_sentence
        render :new }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carts/1
  # PATCH/PUT /carts/1.json
  def update
    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to @cart
        flash[:success] = 'Cart was successfully updated.' }
        format.json { render :show, status: :ok, location: @cart }
      else
        format.html { flash.now[:error] = @cart.errors.full_messages.to_sentence
        render :edit }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    @cart.destroy if @cart.id == session[:cart_id]
    session[:cart_id] = nil
    respond_to do |format|
      format.html { redirect_to carts_url
      flash[:success] = 'Cart was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = Cart.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cart_params
      params.fetch(:cart, {})
    end

    def not_current_user_cart?
      return params[:id].to_i != current_user.cart.id
    end

    def redirect_to_root
      redirect_to items_path
    end

    def invalid_cart
      logger.error "Attempt to access invalid cart #{params[:id]}"
      redirect_to_root
    end
end