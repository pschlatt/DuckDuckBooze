class MerchantsController < ApplicationController

  def index
    if current_admin?
      @merchants = User.where(role: 'merchant')
    else
      @merchants = User.where(role: 'merchant', enabled: true)
    end
  end

end
