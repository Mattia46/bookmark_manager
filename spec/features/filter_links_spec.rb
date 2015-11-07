feature 'Filter links' do
  before(:each) do
    Link.create(title: 'Makers Academy', url: 'www.makersacadamy.com', tags: [Tag.first_or_create(name: 'bootcamps')])
    Link.create(title: 'BBC', url: 'www.bbc.co.uk', tags: [Tag.first_or_create(name: 'news')])
    Link.create(title: 'Google', url: 'www.google.com', tags: [Tag.first_or_create(name: 'searcher')])
    Link.create(title: 'I love bubbles', url: 'www.bubblsrus.com', tags: [Tag.first_or_create(name: 'bubbles')])
  end

  scenario 'filter links by tags' do
    visit '/tags/bubbles'
    expect(page).not_to have_content('BBC')
    expect(page).not_to have_content('Google')
    expect(page).not_to have_content('Makers Academy')
    expect(page).to have_content('I love bubbles')
  end
end
