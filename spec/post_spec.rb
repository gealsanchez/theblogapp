require_relative 'rails_helper'

RSpec.describe Post, type: :model do
  user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Developer', posts_counter: 0)
  post = Post.create(title: 'Code Review', text: 'This is my code review', comments_counter: 0, likes_counter: 0,
                     author: user)
  Comment.create(text: 'Great review one!', author: user, post:)
  Comment.create(text: 'Great review two!', author: user, post:)
  Comment.create(text: 'Great review three!', author: user, post:)
  Comment.create(text: 'Great review four!', author: user, post:)
  Comment.create(text: 'Great review five!', author: user, post:)
  Comment.create(text: 'Great review six!', author: user, post:)
  subject do
    Post.new(title: 'first_post', text: 'This is my first post', comments_counter: 1, likes_counter: 1, author_id: 1)
  end

  before { subject.save }

  it 'title should be present' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'title should be first_post' do
    expect(subject.title).to eql 'first_post'
  end

  it 'title should be maximum 50 words' do
    subject.title = 'x' * 255
    expect(subject).to_not be_valid
  end

  it 'text should be valid' do
    expect(subject.text).to eql 'This is my first post'
  end

  it 'comments counter should be present' do
    subject.comments_counter = nil
    expect(subject).to_not be_valid
  end

  it 'comments counter should be valid' do
    expect(subject.comments_counter).to eql 1
  end

  it 'comments counter should be greater than or equal to 0' do
    subject.comments_counter = -1
    expect(subject).to_not be_valid
  end

  it 'comments counter should be integer' do
    subject.comments_counter = 1.1
    expect(subject).to_not be_valid
  end

  it 'likes counter should be present' do
    subject.likes_counter = nil
    expect(subject).to_not be_valid
  end

  it 'likes counter should be valid' do
    expect(subject.likes_counter).to eql 1
  end

  it 'likes counter should be greater than or equal to 0' do
    subject.likes_counter = -1
    expect(subject).to_not be_valid
  end

  it 'likes counter should be integer' do
    subject.likes_counter = 1.1
    expect(subject).to_not be_valid
  end

  it 'posts counter should be 1' do
    expect(user.posts_counter).to eq(1)
  end

  it 'should return the 3 most recent comments for a given post' do
    expect(post.recent_comments.count).to eq(5)
  end
end
