feature 'add many tags to a link' do
  scenario 'it adds more than one tag to a link' do
    visit '/links/new'
    fill_in 'title', with: 'coca cola'
    fill_in 'url', with: 'www.cocacola.com'
    fill_in 'name', with: 'awful'
    click_button 'Submit'
    visit '/links/new'
    fill_in 'title', with: 'coca cola'
    fill_in 'url', with: 'www.cocacola.com'
    fill_in 'name', with: 'drink'
    click_button 'Submit'
    within 'ul#links' do
      expect(page).to have_content("awful, drink")
      # expect(page).to have_content("")
    end
  end
end
