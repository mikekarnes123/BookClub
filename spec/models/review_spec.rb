require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'Relationships' do
    it {should belong_to :book}
    it {should validate_presence_of :user}
    it {should validate_presence_of :review_headline}
    it {should validate_presence_of :review_body}
    it {should validate_presence_of :review_score}
  end
end
