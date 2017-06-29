require "rails_helper"

RSpec.describe "static_pages/contact.html.erb", type: :view do
  it "has_tag" do
    render
    expect(rendered).to have_tag("h2", text: "contact us")
  end
end
