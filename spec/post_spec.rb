require_relative 'rails_helper'

RSpec.describe Post, type: :model do
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

  it 'should return the 3 most recent comments for a given post' do
    expect(subject.recent_comments.count).to eq(0)
  end
end
