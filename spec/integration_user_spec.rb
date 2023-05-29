require 'rails_helper'

RSpec.describe 'User tests', type: :feature do
  describe 'index page' do
    before(:example) do
      @user = User.create(name: 'Edward', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Developer',
                          posts_counter: 1)
      visit users_path
    end

    it 'renders the username of all users' do
      User.all.each do |user|
        expect(page).to have_content(user.name)
      end
    end

    it 'renders the user profile picture' do
      User.all.each do |user|
        expect(page).to have_xpath("//img[@src = '#{user.photo}' ]")
      end
    end

    it 'should render correct posts counter' do
      User.all.each do |user|
        expect(page).to have_content(user.posts_counter)
      end
    end

    it 'redirected to the user page after click' do
      click_link @user.name
      expect(page).to have_current_path(user_path(@user.id))
    end
  end

  describe 'show tests' do
    before(:example) do
      @user = User.create(name: 'Edward', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Developer',
                          posts_counter: 3)
      @first_post = Post.create(title: 'First', text: 'First post', comments_counter: 1, likes_counter: 1,
                                author: @user)
      @second_post = Post.create(title: 'Second', text: 'Second post', comments_counter: 1, likes_counter: 1,
                                 author: @user)
      @third_post = Post.create(title: 'Third', text: 'Third post', comments_counter: 1, likes_counter: 1,
                                author: @user)
      visit user_path(id: @user.id)
    end
    it 'should render user profile picture' do
      expect(page).to have_xpath("//img[@src = '#{@user.photo}' ]")
    end

    it 'should render username' do
      expect(page).to have_content(@user.name)
    end

    it 'should render posts counter' do
      expect(page).to have_content(@user.posts_counter)
    end

    it 'should render user bio' do
      expect(page).to have_content(@user.bio)
    end

    it 'should render user first 3 posts' do
      expect(page).to have_content(@first_post.text)
      expect(page).to have_content(@second_post.text)
      expect(page).to have_content(@third_post.text)
    end

    it 'should have a button to view user all posts' do
      expect(page).to have_link('See all posts', href: user_posts_path(user_id: @user.id))
    end

    it 'should redirect to the post page' do
      click_link @first_post.text
      expect(page).to have_current_path(user_post_path(user_id: @user.id, id: @first_post.id))
    end

    it 'should redirects to all posts page.' do
      click_link 'See all posts'
      expect(page).to have_current_path(user_posts_path(user_id: @user.id))
    end
  end
end
