feature 'Create a new link' do
  scenario 'add a link and title to the bookmark manager' do
    visit '/links/new'
    fill_in('title', with: 'BBC')
    fill_in('url', with: 'www.bbc.co.uk')
    click_button('Submit')
    within 'ul#links' do
      expect(page).to have_content('BBC')
    end
  end
end
