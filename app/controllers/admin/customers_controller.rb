class Admin::CustomersController < ApplicationController
  def index
    @customer =Customer.all.page(params[:page]).per(15)
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to admin_customer_path(@customer.id)
  end
  
  private

  def customer_params
    params.require(:customer).permit(:nickname, :email, :is_deleted, :profile_image, :self_introduction)
  end
  
end
