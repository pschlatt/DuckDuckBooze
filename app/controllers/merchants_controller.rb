class MerchantsController < ApplicationController

  def index
     @merchants = User.where(role: 'merchant', enabled: true)
  end

end
