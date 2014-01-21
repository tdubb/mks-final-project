class OrganizationsController < ApplicationController

  def index
    @organizations = Organization.all
  end

  def show
    @organization = Organization.find(params[:id])
    @needs = @organization.needs.page(params[:page])
    @need = Need.new 
    @pending = 0
    @offers = @organization.offers
    @offers.each do |offer|
      offer.status == "pending" ? @pending += 1 : @pending
    end  
    @denied = 0
    @offers.each do |offer|
      offer.status == "denied" ? @denied += 1 : @denied
    end  

    @accepted = 0
    @offers = @organization.offers
    @offers.each do |offer|
      offer.status == "accepted" ? @accepted += 1 : @accepted
    end

    @active = 0
    @needs.each do |need|
      need.status == true ? @active += 1 : @active
    end

    respond_to do |format|
      format.html { render action: 'show' }
      format.js { render layout: false }
    end
  end

  def destroy
    @organization = Organization.find(params[:id])
    @organization.destroy
    redirect_to root_path
  end

  def update
    @organization = Organization.find(params[:id])
    @organization.update(organization_params)
  end

  private
  def organization_params
    params.require(:organization).permit(:description, :owner_id, :image)
  end
end