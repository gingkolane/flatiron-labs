require 'rails_helper'

# factory :post do
#   title "My Great Post"
#   description "My amazing description"
# end
describe 'new post' do
  it 'ensures that the form route works with the /new action' do
    visit new_post_path
    expect(page.status_code).to eq(200)
  end
end

feature 'navigate to post pages' do
  subject { FactoryGirl.create(:post) }

  scenario 'on the index page' do
    visit posts_path
    expect(page.status_code).to eq(200)
  end

  scenario 'index page links to post page' do
    second = FactoryGirl.create(:second_post)
    visit posts_path
    expect(page).to have_link(second.title, href: post_path(second))
  end

  scenario 'have the index page render multiple posts' do
    FactoryGirl.create(:second_post)
    visit posts_path
    expect(page).to have_content(/My Great|Second Post/)
  end

  scenario 'on the show page' do
    visit post_path(subject)
    expect(page.status_code).to eq(200)
  end

  scenario 'form route works with new action' do
    visit new_post_path
    expect(page.status_code).to eq(200)
  end

  scenario 'form renders with the new action' do
    visit new_post_path
    expect(page).to have_content("Post Form")
  end

  scenario 'new form submits content and redirects' do
    visit new_post_path

    fill_in 'title', with: "My post title"
    fill_in 'description', with: "My post description"

    click_on "Submit Post"

    expect(page).to have_content("My post title")
  end

  scenario 'title is shown on the show page in a h1 tag' do
    visit post_path(subject)
    expect(page).to have_css("h1", text: "My Great Post")
  end

  scenario 'description is shown on the show page in a p tag' do
    visit post_path(subject)
    expect(page).to have_css("p", text: "My amazing description")
  end
end
