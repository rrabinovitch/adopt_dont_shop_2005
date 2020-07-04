require 'rails_helper'

RSpec.describe Pet do
  describe 'validations' do

  end

  describe 'relationships' do
    it { should belong_to :shelter }
  end

  describe 'methods' do

  end
end
