require "rails_helper"

describe 'when admin visits merchants index page' do
  it 'shows merchant info ability to enable and disable' do
    admin = create(:admin)
    merch1 = create(:merchant)
    merch2 = create(:merchant)
    merch3 = create(:merchant)
    dis_merch = create(:disabled_merchant)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit merchants_path

    within "#merchant-#{merch1.id}" do
      expect(page).to have_link("#{merch1.name}")
      expect(page).to have_content("#{merch1.city}")
      expect(page).to have_content("#{merch1.state}")
      expect(page).to have_button("Disable")
    end
    within "#merchant-#{merch2.id}" do
      expect(page).to have_link("#{merch2.name}")
      expect(page).to have_content("#{merch2.city}")
      expect(page).to have_content("#{merch2.state}")
      expect(page).to have_button("Disable")
    end
    within "#merchant-#{merch3.id}" do
      expect(page).to have_link("#{merch3.name}")
      expect(page).to have_content("#{merch3.city}")
      expect(page).to have_content("#{merch3.state}")
      expect(page).to have_button("Disable")
    end
    within "#merchant-#{dis_merch.id}" do
      expect(page).to have_link("#{dis_merch.name}")
      expect(page).to have_content("#{dis_merch.city}")
      expect(page).to have_content("#{dis_merch.state}")
      expect(page).to have_button("Enable")
    end
  end
end
