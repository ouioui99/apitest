class AddressController < ApplicationController

  def index
    @zipcodes = Zip.all
  end

  def new
    @zip = Zip.new
  end

  def create
    @zipcode = Zip.new(params)
    @zipcode.save
  end

end







