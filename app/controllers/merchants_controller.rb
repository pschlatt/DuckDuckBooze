class MerchantsController < ApplicationController

  def index
    binding.pry
    @merchants = User.where(role: 'merchant', enabled: true)
  end

end
