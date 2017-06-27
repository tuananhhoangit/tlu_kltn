require "rails_helper"

RSpec.describe Comment, type: :model do
  context "associaitons" do
    it {expect belong_to :user}
    it {expect belong_to :post}
  end
end
