require 'rails_helper'

describe 'User can visit welcome page' do
  it 'User can search for nearest station to turing' do
    visit '/'
    click_button 'Find Nearest Station'

    expect(page).to have_content()
  end
end
