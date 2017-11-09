require "rails_helper"

RSpec.describe "news/show.html.erb", type: :view do
  let(:user) {FactoryBot.create :user}
  let(:new) do
    FactoryBot.create :new, user: user, title: "Title of new in test",
      content: "This content minium is 1000 character."*100
  end
  let!(:comments) {FactoryBot.create :comment, user: user, target: new}

  before(:each) do
    assign :newdetail, new
    assign :comments, new.comments.paginate(page: params[:page])
    render
  end

  it "Displays title of new" do
    expect(rendered).to include("<h1>Title of new in test</h1>")
  end

  it "Displays content of new" do
    expect(rendered).to include(%Q(<p class="new-content">#{'This content minium is 1000 character.'*100}</p>))
  end
  it "Displays title comment" do
    expect(rendered).to include("<h3>Comments</h3>")
  end

  it "Displays name of user commented this new" do
    expect(rendered).to include(%Q(<h4 class="media-heading">name of user))
  end

  it "Do not displays button summit comment" do
    expect(rendered).not_to include(%Q(<div class="panel-heading">Comments</div>))
  end
end
