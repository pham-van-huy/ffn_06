require "rails_helper"
RSpec.describe User, type: :model do
  context "association" do
    it{is_expected.to have_many :bets}
    it{is_expected.to have_many :new}
    it{is_expected.to have_one(:social_account).class_name('Social_account').dependent(:destroy)}
  end
  context "validates" do
    it {is_expected.to validate_presence_of :email}
    it {is_expected.to validate_length_of(:email).is_at_most(Settings.user.email_length)}
    it {is_expected.to validate_uniqueness_of(:email).case_insensitive}
    it {is_expected.to validate_length_of(:password).is_at_least(Settings.user.password_length)}
    it {is_expected.to validate_presence_of :password}
    it {is_expected.to validate_presence_of :password}
  end
end
