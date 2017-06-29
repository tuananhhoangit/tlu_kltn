require "rails_helper"

RSpec.describe "static_pages/about.html.erb", type: :view do
  it "has_tag" do
    render
    expect(rendered).to have_tag("h2", text: "About Us")
  end
end
