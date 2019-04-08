class MerchantsController < ApplicationController

  def index
    if current_admin?
      @merchants = User.where(role: 'merchant')
    else
      @merchants = User.where(role: 'merchant', enabled: true)
    end
    @merchants_top_rev = User.top_three_rev
    @merchants_fastest = User.top_three_fast
  end

end
