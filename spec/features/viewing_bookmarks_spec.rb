feature 'Viewing bookmarks' do
  scenario 'visiting the index page' do
    visit('/')
    expect(page).to have_content "Bookmark Manager"
  end
end

feature 'Viewing bookmarks' do
  scenario 'A user can see bookmarks' do
    
    # Add the test data
    Bookmark.create(url: "http://www.makersacademy.com")
    Bookmark.create(url: "http://www.askjeeves.com")
    Bookmark.create(url: "http://www.google.com")

    visit('/bookmarks')

    expect(page).to have_content "http://www.makersacademy.com"
    expect(page).to have_content "http://www.askjeeves.com"
    expect(page).to have_content "http://www.google.com"
  end
end