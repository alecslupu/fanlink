require 'rails_helper'

RSpec.describe CertificateCertcourse, type: :model do

  context "Valid factory" do
    it { expect(create(:certificate_certcourse)).to be_valid }
  end

  context "Validation" do
    it "uniqueness to tenant" do
      cc = create(:certificate_certcourse)
      cc2 = build(:certificate_certcourse,
                   product: cc.product,
                   certcourse: cc.certcourse,
                   certificate: cc.certificate,
                    certcourse_order: cc.certcourse_order
      )
      expect(cc2.valid?).to be_falsey
      cc2.certcourse_order += 1
      expect(cc2.valid?).to be_truthy
    end
  end

  context "Associations" do
    subject { create(:certificate_certcourse) }

    it { should belong_to(:product) }
    it { should belong_to(:certcourse) }
    it { should belong_to(:certificate) }
  end


  describe "scopes" do
    describe "for_certificate" do
      it "has" do
        cc = create(:certificate_certcourse)
        test = CertificateCertcourse.for_certificate(cc.certificate)
        expect(test.count).to eq(1)
        expect(test.first).to eq(cc)
      end
      it "does not" do
        cc = create(:certificate_certcourse)
        cc2 = create(:certificate_certcourse)
        test = CertificateCertcourse.for_certificate(cc.certificate)
        expect(test.count).to eq(1)
        expect(test.first).not_to eq(cc2)
      end
    end
    describe "for_certcourse" do
      it "has" do
        cc = create(:certificate_certcourse)
        test = CertificateCertcourse.for_certcourse(cc.certcourse)
        expect(test.count).to eq(1)
        expect(test.first).to eq(cc)
      end

      it "does not" do
        cc = create(:certificate_certcourse)
        cc2 = create(:certificate_certcourse)
        test = CertificateCertcourse.for_certcourse(cc.certcourse)
        expect(test.count).to eq(1)
        expect(test.first).not_to eq(cc2)
      end
    end
  end

end
