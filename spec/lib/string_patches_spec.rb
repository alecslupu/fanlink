# frozen_string_literal: true
describe "StringPatches" do
  it "should remove accents" do
    expect("åéİÕüçûx".de_accent).to eq("aeIOucux")
    expect("ÅÉIÕÜÇÛX".de_accent).to eq("AEIOUCUX")
  end

  it "should properly upcase simple Unicode" do
    expect("åéiõüçûx".upcase_u).to eq("ÅÉIÕÜÇÛX")
  end

  it "should downcase simple Unicode" do
    expect("ÅÉIÕÜÇÛX".downcase_u).to eq("åéiõüçûx")
  end

  it "should scan with MatchData" do
    matches = "where is pancakes house?".scanm(/\w+/)
    expect(matches.map(&:class)).to eq([MatchData] * 4)
    expect(matches.map(&:to_s)).to eq(%w[where is pancakes house])
  end

  describe "is_integer?" do
    it "should return true for a single digit integer" do
      expect("1".is_integer?).to be_truthy
    end
    it "should return true for a multi digit integer" do
      expect("12".is_integer?).to be_truthy
    end
    it "should return false for an alpha string" do
      expect("abc".is_integer?).to be_falsey
    end
    it "should return false for an alphanumeric string" do
      expect("abc12".is_integer?).to be_falsey
    end
  end
end
