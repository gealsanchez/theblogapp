require_relative 'rails_helper'

RSpec.describe Like, type: :model do
  user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Developer', posts_counter: 0)
  post = Post.create(title: 'Code Review', text: 'This is my code review', comments_counter: 0, likes_counter: 0,
                     author: user)
  subject { Like.new(author: user, post:) }

  before { subject.save }

  it 'likes counter should be 1' do
    expect(post.likes_counter).to eq 1
  end

  it 'should not be valid without an author' do
    subject.author = nil
    expect(subject).to_not be_valid
  end

  it 'should not be valid without a post' do
    subject.post = nil
    expect(subject).to_not be_valid
  end
end
