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
end
