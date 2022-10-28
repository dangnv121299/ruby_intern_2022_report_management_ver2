RSpec.shared_examples "shared render" do |type|
  it { expect(response).to render_template(type) }
end

