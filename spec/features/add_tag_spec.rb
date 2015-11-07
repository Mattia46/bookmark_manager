feature 'add tag' do
  scenario 'it adds a single tag to a link' do
    visit '/links/new'
    fill_in 'title', with: 'coca cola'
    fill_in 'url', with: 'www.cocacola.com'
    fill_in 'name', with: 'awful'
    click_button 'Submit'
    within 'ul#links' do
      expect(page).to have_content("awful")
    end
  end
end
