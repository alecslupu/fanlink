# frozen_string_literal: true

describe "StringUtil" do
  it "should leave ASCII alphanumerics alone when search-ifying" do
    expect(StringUtil.search_ify("muis2short")).to eq("muis2short")
  end

  it "should strip out punctuation when search-ifying" do
    expect(StringUtil.search_ify("mu.is,too-short_")).to eq("muistooshort")
  end

  it "should leave non-accented non-ASCII alone when search-ifying" do
    expect(StringUtil.search_ify("µistøøshort")).to eq("μistøøshort")
  end

  it "should strip off accents when search-ifying" do
    expect(StringUtil.search_ify("åéİÕü")).to eq("aeiou")
    expect(StringUtil.search_ify("ÅÉiõÜ")).to eq("aeiou")
  end

  it "should deal with spaces when url-ifying" do
    expect(StringUtil.url_ify("One  cent\tstamp")).to eq("One-cent-stamp")
  end

  it "should deal with accents when url-ifying" do
    expect(StringUtil.url_ify("Öné cent ståmp")).to eq("One-cent-stamp")
  end

  it "should deal with punctuation when url-ifying" do
    expect(StringUtil.url_ify("One cent & stamp")).to eq("One-cent-%26-stamp")
  end

  it "should deal with unicode when url-ifying" do
    expect(StringUtil.url_ify("µistøøshort")).to eq("%CE%BCist%C3%B8%C3%B8short")
  end
end
