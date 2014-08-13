require 'spec_helper'
require 'rails_helper'

describe "Users" do
	let(:user) { create(:user) }
	describe "POST /users" do
		it "registers" do
			new_user = build(:user)
			visit new_user_path
			fill_in :user_name, with:new_user.name
			fill_in :user_email, with:new_user.email
			fill_in :user_password, with:new_user.password
			fill_in :user_password_confirmation, with:new_user.password
			click_button "Register"
			expect(page).to have_content("Welcome, #{new_user.name}!")
    	end

		it "does not allow duplicate email" do
			new_user = build(:user)
			visit new_user_path
			fill_in :user_name, with:new_user.name
			fill_in :user_email, with:user.email
			fill_in :user_password, with:new_user.password
			fill_in :user_password_confirmation, with:new_user.password
			click_button "Register"
			expect(page).to have_content("Email has already been taken")
		end
  	end
end
