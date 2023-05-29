require 'rails_helper'

RSpec.describe 'Post index tests', type: :feature do
  describe 'index page' do
    before(:example) do
      @user = User.create(name: 'Edward', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Developer',
                          posts_counter: 1)
      @post = Post.create(title: 'title', text: 'This is my post', comments_counter: 2, likes_counter: 1, author: @user)
      @first_comment = Comment.create(text: 'This is a comment', author: @user, post: @post)
      @second_comment = Comment.create(text: 'This is another comment', author: @user, post: @post)
      Like.create(author: @user, post: @post)
      visit user_posts_path(user_id: @user.id)
    end

    it 'should render profile picture' do
      expect(page).to have_xpath("//img[@src = '#{@post.author.photo}' ]")
    end

    it 'should render author name' do
      expect(page).to have_content(@post.author.name)
    end

    it 'should render posts counter' do
      expect(page).to have_content(@post.author.posts_counter)
    end

    it 'should render post title' do
      expect(page).to have_content(@post.title)
    end

    it 'should render post body' do
      expect(page).to have_content(@post.text)
    end

    it 'should render the first comment' do
      expect(page).to have_content('This is a comment')
    end

    it 'should render how many comments' do
      expect(page).to have_content(@post.comments_counter)
    end

    it 'should render how many likes' do
      expect(page).to have_content(@post.likes_counter)
    end

    it 'should render the pagination button' do
      expect(page).to have_content('Pagination')
    end

    it 'When I click on a post, it redirects me to that posts show page' do
      click_link @post.text
      expect(page).to have_current_path(user_post_path(user_id: @user.id, id: @post.id))
    end
  end

  describe 'Post show tests' do
    before(:example) do
      @user1 = User.create(name: 'Edward', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Developer',
                           posts_counter: 1)
      @user2 = User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Engineer',
                           posts_counter: 1)
      @post = Post.create(title: 'title', text: 'This is my post', comments_counter: 2, likes_counter: 1,
                          author: @user1)
      @first_comment = Comment.create(text: 'This is a comment', author: @user1, post: @post)
      @second_comment = Comment.create(text: 'This is another comment', author: @user2, post: @post)
      Like.create(author: @user1, post: @post)
      visit user_post_path(user_id: @user1.id, id: @post.id)
    end

    it 'should render post title' do
      expect(page).to have_content('title')
    end

    it 'should render post author' do
      expect(page).to have_content(@post.author.name)
    end

    it 'should render how many comments' do
      expect(page).to have_content(@post.comments_counter)
    end
    it 'should render how many likes' do
      expect(page).to have_content(@post.likes_counter)
    end
    it 'should render post body' do
      expect(page).to have_content(@post.text)
    end
    it 'should render the username of each commentor' do
      expect(page).to have_content(@user1.name)
      expect(page).to have_content(@user2.name)
    end
    it 'should render the comment each commentor left' do
      expect(page).to have_content(@first_comment.text)
      expect(page).to have_content(@second_comment.text)
    end
  end
end
