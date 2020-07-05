require 'rails_helper'

RSpec.describe Pet do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :sex }
    it { should validate_presence_of :age }
  end

  describe 'relationships' do
    it { should belong_to :shelter }
  end

  describe 'methods' do

  end
end
