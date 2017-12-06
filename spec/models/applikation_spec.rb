require 'rails_helper'

RSpec.describe Applikation, type: :model do

  describe '#subdomain' do
    it 'should accept a good subdomain format' do
      appl = FactoryBot.create(:applikation, subdomain: "goodone")
      expect(appl).to be_valid
    end
  end

end
