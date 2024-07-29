require 'rails_helper'

RSpec.describe Transaction, type: :model do 
  describe "validations" do
    it { should validate_presence_of(:credit_card_number) }
<<<<<<< HEAD
    it { should validate_presence_of(:credit_card_number) }
=======
>>>>>>> e412cbe9771b59313d8e2635a8c638e8bf304546
    it { should validate_presence_of(:credit_card_expiration_date) }
    it { should validate_presence_of(:result) }
  end
  
  describe "relationships" do 
    it { should belong_to(:invoice)}
  end

end