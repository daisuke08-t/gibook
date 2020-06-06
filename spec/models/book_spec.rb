require 'rails_helper'

RSpec.describe Book, type: :model do
  
  let!(:user) {FactoryBot.create(:user)}
  let!(:book) {FactoryBot.create(:book)}
  
  it "user_id, titleがあれば有効" do
    
    expect(book).to be_valid
  end
  
  it "user_idが無ければ無効" do
    
    book.user_id = nil
    
    book.valid?
    
    expect(book.errors[:user_id]).to include("can't be blank")
  end
  
  it "titleがなければ無効" do
    
    book.title = nil
    
    book.valid?
    
    expect(book.errors[:title]).to include("can't be blank")
  end
  
end
