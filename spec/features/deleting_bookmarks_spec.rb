feature 'Deleting a bookmark' do 
  scenario 'A user can delete a bookmark' do 
    # setting up test data 
    Bookmark.create(url: 'http://www.makersacademy.com', title: 'Makers Academy')
    visit('/bookmarks')
    #checking data is present 
    expect(page).to have_link('Makers Academy', href: 'http://www.makersacademy.com') 
    #carrying out delete action
    first('.bookmark').click_button 'Delete'

    expect(current_path).to eq '/bookmarks'
    #checking data is no longer present
    expect(page).not_to have_link('Makers Academy', href: 'http://www.makersacademy.com')
  end 
end