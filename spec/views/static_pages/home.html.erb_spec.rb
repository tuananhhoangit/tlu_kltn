require "rails_helper"

RSpec.describe "static_pages/home.html.erb", type: :view do
  it "has_tag" do
    render
    expect(rendered).to have_tag("a", text: "Sign up")
  end
end
