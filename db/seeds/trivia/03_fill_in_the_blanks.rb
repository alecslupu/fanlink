require 'csv'
csv_text = %Q(Game,Game Name,Game Description,Round Number,Round Description,Question Order,Complexity,Question Type,Topic,Question,Number of Answers,Answer 1,Visible Characters,Imported
1,All About Cannabis,Think you know Cannabis?  Test your knowledge with this trivia game.,1,,4,1,Fill in the Blank,Growing Cannabis,All of the crystals that make your buds beautiful and camera ready. These are actually glands that are protecting the plant and producing the highest concentration of THC/CBD in the plant.,1,Trichomes,2;4;7,1
1,All About Cannabis,Think you know Cannabis?  Test your knowledge with this trivia game.,1,,1,1,Fill in the Blank,Cannabis Culture,"Who sang the song ""I Got 5 On It""",1,The Luniz,2;5;8,1
1,All About Cannabis,Think you know Cannabis?  Test your knowledge with this trivia game.,2,,6,1,Fill in the Blank,Cannabis Terms and Definitions,What is the slang term for consuming cannabis concentrates?,1,Dabbing,3;4,1
1,All About Cannabis,Think you know Cannabis?  Test your knowledge with this trivia game.,2,,5,1,Fill in the Blank,Cannabis Terms and Definitions,This is an authorized location where patients can find and purchase cannabis products.,1,Access Point,3;4;7,1
1,All About Cannabis,Think you know Cannabis?  Test your knowledge with this trivia game.,3,,1,1,Fill in the Blank,Legal Cannabis Worldwide,This is approximately 7 grams of marijuana.,1,Quarter,2;4;5,1
1,All About Cannabis,Think you know Cannabis?  Test your knowledge with this trivia game.,3,,5,1,Fill in the Blank,Cannabis Culture,This Cheech and Chong movie was released in 1981 and had the duo selling marijuana out of an ice truck. Name the movie.,1,Nice Dreams,2;4;5;10,1
1,All About Cannabis,Think you know Cannabis?  Test your knowledge with this trivia game.,4,,5,1,Fill in the Blank,Cannabis Terms and Definitions,The process of removing impurities and unwanted elements from cannabis extract. High-quality distillates often go through this several times to create a finished product.,1,Refinement,1;3;7;10,1
1,All About Cannabis,Think you know Cannabis?  Test your knowledge with this trivia game.,4,,3,1,Fill in the Blank,Methods of Consumption,"Widely popular in Europe, what is a joint that combines tobacco and cannabis.",1,Spliff,5;6,1
1,All About Cannabis,Think you know Cannabis?  Test your knowledge with this trivia game.,5,,1,1,Fill in the Blank,Facts and Myths,What is the name of the Indian milkshake whose main ingredient is marijuana?,1,Bhang,2;3,1
1,All About Cannabis,Think you know Cannabis?  Test your knowledge with this trivia game.,5,,5,1,Fill in the Blank,Cannabis Culture,This west coast legend gave Dina Browner the nick name Dr. Dina.,1,Snoop Dogg,2;3;6,1
1,All About Cannabis,Think you know Cannabis?  Test your knowledge with this trivia game.,6,,3,1,Fill in the Blank,Facts and Myths,_______ requires minimal care and can grow in most climates and is usually used for industrial purposes.,1,Hemp,2,1
1,All About Cannabis,Think you know Cannabis?  Test your knowledge with this trivia game.,7,,6,1,Fill in the Blank,Legal Cannabis Worldwide,"Which former US President said: ""I tried marijuana once.  I did not inhale.""?",1,Bill Clinton,2;5;6,1
2,Cannabis Culture,Test your knowledge on Cannabis and the culture!,1,,4,1,Fill in the Blank,Methods of Consumption,This device breaks up cannabis flower and stems to be easily used for smoking,1,Grinder,1;7,1
2,Cannabis Culture,Test your knowledge on Cannabis and the culture!,2,,2,1,Fill in the Blank,Science of Cannabis,You shouldn't prune or pinch plants once they've begun ______.,1,flowering,3;4;9,1
2,Cannabis Culture,Test your knowledge on Cannabis and the culture!,3,,5,1,Fill in the Blank,Cannabis Terms and Definitions,"This slang term is often used to described very sticky, very pungent cannabis.",1,Dank,2,1
2,Cannabis Culture,Test your knowledge on Cannabis and the culture!,3,,1,1,Fill in the Blank,Cannabis Terms and Definitions,What smoking device is usually made of glass that has a water reservoir at the bottom to cool smoke before it's inhaled,1,Bubbler,1;5,1
2,Cannabis Culture,Test your knowledge on Cannabis and the culture!,4,,3,1,Fill in the Blank,Methods of Consumption,_______ _______ are a smaller version of a vaporizer.,1,Vape pens,1;5;8,1
2,Cannabis Culture,Test your knowledge on Cannabis and the culture!,5,,5,1,Fill in the Blank,Cannabis Terms and Definitions,"This term refers to the actual flower of the cannabis plant that are fluffy and harvested to smoke in joints, bongs, etc.?",1,Bud,2,1
2,Cannabis Culture,Test your knowledge on Cannabis and the culture!,5,,3,1,Fill in the Blank,History,"Who was quoted in 1794 saying ""Make the most you can of the Indian Hemp seed and sow it everywhere.""",1,George Washington,3;4;9;10,1
2,Cannabis Culture,Test your knowledge on Cannabis and the culture!,6,,5,1,Fill in the Blank,History,What is the name of the act the United States government enacted that banned the use and sale of cannabis?,1,Marihuana Tax Act,3;5;10,1
2,Cannabis Culture,Test your knowledge on Cannabis and the culture!,7,,2,1,Fill in the Blank,Legal Cannabis Worldwide,"In the Canadian province of Saskatchewan, public consumption is _________.",1,prohibited,1;7;8,1
2,Cannabis Culture,Test your knowledge on Cannabis and the culture!,8,,4,1,Fill in the Blank,Cannabis Culture,Keith Stroup founded this cannabis rights organization in 1970.,1,NORML,2,1
3,The Green Rush,All about the canna-BIZ,1,,4,1,Fill in the Blank,History,"In 1545, Spaniards imported cannabis to what country as fiber?",1,Chile,5,1
3,The Green Rush,All about the canna-BIZ,2,,1,1,Fill in the Blank,Methods of Consumption,________ make use of a rolled cigar as Methods of Consumption,1,Blunts,2;6,1
3,The Green Rush,All about the canna-BIZ,2,,5,1,Fill in the Blank,Science of Cannabis,The step of cultivation that comes after drying the flower is:,1,curing,2;5,1
3,The Green Rush,All about the canna-BIZ,3,,4,1,Fill in the Blank,Cannabis Culture,Who founded The National Organization for the Reform of Marijuana Laws in 1970?,1,Keith Stroup,2;4;8,1
3,The Green Rush,All about the canna-BIZ,3,,3,1,Fill in the Blank,Methods of Consumption,Which brand of rolling paper has patterns printed on them to match the flavor of the paper?,1,Juicy Jay's,3;5;7,1
3,The Green Rush,All about the canna-BIZ,4,,3,1,Fill in the Blank,Legal Cannabis Worldwide,"What former US President said: ""When I was a kid I inhaled frequently.  That was the point.""?",1,Barack Obama,2;6;7,1
3,The Green Rush,All about the canna-BIZ,5,,4,1,Fill in the Blank,Cannabis Terms and Definitions,What does one call a clipping from a cannabis plant that can be rooted and grown?,1,Clone,2;3,1
3,The Green Rush,All about the canna-BIZ,6,,1,1,Fill in the Blank,Cannabis Terms and Definitions,"This slang for marijuana, was also an album by Dr. Dre released in 1992.",1,The Chronic,1;6;7,1
3,The Green Rush,All about the canna-BIZ,6,,6,1,Fill in the Blank,Facts and Myths,Hemp has lower concentrations of THC and higher concentrations of this.,1,CBD,,1
3,The Green Rush,All about the canna-BIZ,7,,4,1,Fill in the Blank,Cannabis Culture,High Times magazine released what documentary film in 1990?,1,Let Freedom Ring,2;3;7;9,1
3,The Green Rush,All about the canna-BIZ,8,,6,1,Fill in the Blank,Methods of Consumption,A marijuana ______ can be made by replacing the tobacco with marijuana,1,Blunt,1,1
3,The Green Rush,All about the canna-BIZ,8,,2,1,Fill in the Blank,Cannabis Terms and Definitions,What term is often used to refer to individuals working behind the counter at your local dispensary?,1,Budtender,3;4;6,1
4,It's All About The Ganja,Ganja Trivia,1,,4,1,Fill in the Blank,History,Cannabis pollen was recovered from what Pharaohs mummy?,1,Ramesses II,1;6;7,1
4,It's All About The Ganja,Ganja Trivia,1,,5,1,Fill in the Blank,Science of Cannabis,This element is necessary for the proper growth of the root of the cannabis plant.,1,Sulfur,2;6,1
4,It's All About The Ganja,Ganja Trivia,2,,2,1,Fill in the Blank,Methods of Consumption,A joint where marijuana is mixed using loose tobacco ,1,Spliff,1,1
4,It's All About The Ganja,Ganja Trivia,3,,3,1,Fill in the Blank,Science of Cannabis,What element is one of the most important parts of every plant?,1,Nitrogen,1;6,1
4,It's All About The Ganja,Ganja Trivia,3,,6,1,Fill in the Blank,Science of Cannabis,Cannabis reduces the spasticity associated with what disease?,1,multiple sclerosis,1;3;10,1
4,It's All About The Ganja,Ganja Trivia,4,,6,1,Fill in the Blank,Legal Cannabis Worldwide,"What North American country legalized cannabis for recreational purposes on October 17, 2018?",1,Canada,2;5;6,1
4,It's All About The Ganja,Ganja Trivia,5,,5,1,Fill in the Blank,Methods of Consumption,This hip hop star loves RAW rolling papers so much they wrote a song by the same title about them.,1,Wiz Khalifa,2;3,1
4,It's All About The Ganja,Ganja Trivia,6,,3,1,Fill in the Blank,Methods of Consumption,This brand of rolling paper became a reference in pop culture largely due to the release of Cheech and Chong in the 70's.,1,Bambú,2;3,1
4,It's All About The Ganja,Ganja Trivia,7,,2,1,Fill in the Blank,Strains,"These strains keep you up, give you energy and are best suited for running errands, hiking, and activities that require focus.",1,Sativa,3;4;6,1
4,It's All About The Ganja,Ganja Trivia,8,,1,1,Fill in the Blank,Science of Cannabis,"Nitrogen is a building material for enzymes, proteins, and:",1,chlorophyll,1;4;5,1
,,,,,,1,Fill in the Blank,Science of Cannabis,The process of freezing crude oil diluted in solvent to separate plant fats and liquids.,1,Winterize,1;3;6,1
,,,,,,1,Fill in the Blank,Facts and Myths,This is a term for a marijuana product that can be either be food or drink.,1,Derived from Latin,1;3;8;9;11;15,1
,,,,,,1,Fill in the Blank,Methods of Consumption,The power unit used to heat cannabis oil into an inhalable vapor.,1,Vape Pen,1;5,1
,,,,,,1,Fill in the Blank,Cannabis Terms and Definitions,What is the name of marijuana rolled up in a cigar?,1,Blunt,2;3;5,1
,,,,,,1,Fill in the Blank,Science of Cannabis,Cannabis grown in full sun and also referred to as “outdoor.”,1,Sun Grow,2;4;7,1
,,,,,,1,Fill in the Blank,Cannabis Terms and Definitions,What girl's name is commonly a slang term for marijuana?,1,Mary Jane,2;5;8,1
,,,,,,1,Fill in the Blank,Science of Cannabis,What system is ideal for areas that are prone to drought or dry climates?,1,hydroponic,1;5;8,1
,,,,,,1,Fill in the Blank,Cannabis Culture,"In 2003, this notable cannabis freedome fighter helped to establish LA's first medical marijuana doctor's office.",1,Dina Browner,2;5;6,1
,,,,,,1,Fill in the Blank,Cannabis Culture,"After moving to LA in 1967, this freedom fighter opened the first hemp store and headshop on Venice Beach.",1,Jack Herer,2;3;6,1
,,,,,,1,Fill in the Blank,Science of Cannabis,This piece of equipment is used to house cannabis plants when grown indoors.,1,Grow Tent,2;3;6,1
,,,,,,1,Fill in the Blank,Science of Cannabis,An exhaust fan is used at indoor cannabis grows to reduce what eliment?,1,Heat,2,1
,,,,,,1,Fill in the Blank,Science of Cannabis,Marijuana helps to relieve nausea and what else in chemotherapy patients?,1,vomiting,1;4,1
,,,,,,1,Fill in the Blank,History,"In 4000 B.C., cannabis was farmed as a major food crop in what country?",1,China,2;3,1
,,,,,,1,Fill in the Blank,Cannabis Culture,Jane West and Jazmin Hupp founded this orginzation in 2014.,1,Women Grow,2;3;5,1
,,,,,,1,Fill in the Blank,Facts and Myths,"There are over 100 chemical compounds in cannabis, what are they called?",1,cannabinoids,5;6,1
,,,,,,1,Fill in the Blank,Cannabis Terms and Definitions,What are baked goods or consumable food infused with cannabis often referred to?,1,Edibles,2;3,1
,,,,,,1,Fill in the Blank,Cannabis Terms and Definitions,These are chemical compounds unique to cannabis that work with the body's receptors by the same name.,1,Cannabinoids,2;4;6,1
,,,,,,1,Fill in the Blank,Cannabis Terms and Definitions,What is the name for cannabis wrapped in a tobacco leaf cigar or cigarillo paper?,1,Blunt,4,1
1,Are You A CannaWIZ?,Do you consider your brain the encyclopedia of cannabis?  Test your knowledge now!,1,,3,2,Fill in the Blank,Methods of Consumption,A joint where marijuana is mixed using loose tobacco ,1,Spliff,2;3,1
1,Are You A CannaWIZ?,Do you consider your brain the encyclopedia of cannabis?  Test your knowledge now!,1,,4,2,Fill in the Blank,Strains,"The strain 3 Kings was named after it's unique genetics which include Sour Diesel, OG Kush and what other noteably popular cannabis strain?",1,Headband,1;2;6;8,1
1,Are You A CannaWIZ?,Do you consider your brain the encyclopedia of cannabis?  Test your knowledge now!,1,,9,2,Fill in the Blank,Strains,"Which strain is mixed with Chem's Sister, Sour Dubb and Chocolate Diesel?",1,Original Glue,2;9,1
1,Are You A CannaWIZ?,Do you consider your brain the encyclopedia of cannabis?  Test your knowledge now!,2,,3,2,Fill in the Blank,Strains,The cross of Blue Cookies and Sunset Sherbert makes what strain?,1,Blue Sherbert,2;3;7,1
1,Are You A CannaWIZ?,Do you consider your brain the encyclopedia of cannabis?  Test your knowledge now!,3,,3,2,Fill in the Blank,Cannabis Culture,"In the 1998 movie, ""Half Baked"" what is the first name of Harland Williams character?",1,Kenny,1;4;5,1
1,Are You A CannaWIZ?,Do you consider your brain the encyclopedia of cannabis?  Test your knowledge now!,3,,9,2,Fill in the Blank,Cannabis Culture,"Actor and activist for marijuana use, Tommy Chong also has a daughter who was in the movies ""Quest for Fire"", ""Commando"" with Arnold Schwarzenegger and ""The Color Purple"". Who is she?  ",1,Rae Dawn Chong,1;5;7;9;11;12,1
1,Are You A CannaWIZ?,Do you consider your brain the encyclopedia of cannabis?  Test your knowledge now!,4,,5,2,Fill in the Blank,Methods of Consumption,A  ______ can be made by replacing the tobacco in a cigar with marijuana flower.,1,Blunt,4,1
1,Are You A CannaWIZ?,Do you consider your brain the encyclopedia of cannabis?  Test your knowledge now!,5,,2,2,Fill in the Blank,Cannabis Culture,The ______ religion is famous for using cannabis as a sacred herb.,1,Rastafari,1;3;7;9,1
1,Are You A CannaWIZ?,Do you consider your brain the encyclopedia of cannabis?  Test your knowledge now!,5,,9,2,Fill in the Blank,Legal Cannabis Worldwide,What was the first country to legalize marijuana in 2013?,1,Uruguay,1;4;6,1
2,420 Know It All,Flex your cannabis knowledge now!,1,,5,2,Fill in the Blank,Cannabis Culture,"""When you smoke the herb, it reveals you to yourself."" was said by who?",1,Bob Marley,2;4;8,1
2,420 Know It All,Flex your cannabis knowledge now!,2,,3,2,Fill in the Blank,Strains,Under what classification does the strain 98 Aloha White Widow fall under?,1,Hybrid,2;5;6,1
2,420 Know It All,Flex your cannabis knowledge now!,2,,8,2,Fill in the Blank,Science of Cannabis,This element is essnetial for photosynthesis as it is part of chlorophyll in all plants.,1,Magnesium,2;6;7,1
2,420 Know It All,Flex your cannabis knowledge now!,2,,1,2,Fill in the Blank,Legal Cannabis Worldwide,"In the Canadian province of Manitoba, public consumption of cannabis is ________.",1,restricted,2;3;6,1
2,420 Know It All,Flex your cannabis knowledge now!,2,,9,2,Fill in the Blank,Strains,Which strain combines Gorilla Glue #4 and Thin Mint Girl Scout Cookies?,1,Gorilla Cookies,2;3;7;10,1
2,420 Know It All,Flex your cannabis knowledge now!,2,,4,2,Fill in the Blank,Legal Cannabis Worldwide,Which state's legislators made the use and cultivation of cannabis a misdemeanor in 1917?,1,Colorado,5;6,1
2,420 Know It All,Flex your cannabis knowledge now!,3,,8,2,Fill in the Blank,Legal Cannabis Worldwide,"What was the name of the document sent to all United States Attorneys and was formally titled ""Guidance Regarding Marijuana Enforcement"". It was issued in 2013 during the Obama administration and was rescinded by Attorney General Jeff Sessions in 2018.",1,The Cole Memorandum,1;4;6;9,1
2,420 Know It All,Flex your cannabis knowledge now!,3,,4,2,Fill in the Blank,Methods of Consumption,_______ _______ are a smaller version of a vaporizer,1,Vape pens,2;5,1
2,420 Know It All,Flex your cannabis knowledge now!,4,,6,2,Fill in the Blank,Methods of Consumption,A sacred Rastafari water pipe.,1,Chalice,2;3;6;7,1
2,420 Know It All,Flex your cannabis knowledge now!,4,,9,2,Fill in the Blank,Science of Cannabis,This element is an important part of the cell walls of the cannabis plant.,1,Calcium,3;4;5,1
2,420 Know It All,Flex your cannabis knowledge now!,5,,8,2,Fill in the Blank,Science of Cannabis,A cognitive side effect of using cannabis can be:,1,Sensory perception,1;4;10;15;17,1
2,420 Know It All,Flex your cannabis knowledge now!,5,,1,2,Fill in the Blank,Science of Cannabis,"The element ______ is absolutely essential in the early stages of plant growth, photosynthesis, and protein production.",1,Potassium,2;7,1
,,,,,,2,Fill in the Blank,Science of Cannabis,_______ carries the chemical to the brain and other organs throughout the body.,1,Blood,2;3,1
,,,,,,2,Fill in the Blank,Strains,Under what classification does the strain 13 Dawgs fall under?,1,Hybrid,1;3;6,1
,,,,,,2,Fill in the Blank,Growing Cannabis,"What growing medium gives the experience of growing cannabis in soil, but have many of the same benefits as growing the plant hydroponically?",1,Coco coir,1;4;5;8,1
,,,,,,2,Fill in the Blank,Strains,24k Gold is a cross between Kosher Kush and what other strain?,1,Tangie,1;6,1
,,,,,,2,Fill in the Blank,Cannabis Freedom Fighters,The National Organization for the Reform of Marijuana Laws was founded in 1970 by who?,1,Keith Stroup,2;4;8;11,1
,,,,,,2,Fill in the Blank,Science of Cannabis,One cognitive side effect of using cannabis is:,1,Reaction time,2;4;8;12,1
,,,,,,2,Fill in the Blank,History,What geographical area is cannabis indigenous to?,1,Central Asia,2;6;8,1
,,,,,,2,Fill in the Blank,Science of Cannabis,The use of a carbon filter at an inside grow helps to what?,1,Eliminate odor,2;6;8,1
,,,,,,2,Fill in the Blank,Strains,This indica strain is also the name of a sweet treat,1,Bubblegum,3;4;9,1
,,,,,,2,Fill in the Blank,Science of Cannabis,What causes cannabis to be purple?,1,Anthocyanin,3;6;7;8;11,1
,,,,,,2,Fill in the Blank,Methods of Consumption,This is made by eliminating the plant material of marijuana and collecting the trichomes from the flower parts of the female cannabis plants.,1,Hashish,4;5;7,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,1,,10,3,Fill in the Blank,Cannabis Culture,"Who said: ""I find it quite ironic that the most dangerous thing about weed is getting caught with it.""",1,Bill Murray,2;5;7,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,1,,4,3,Fill in the Blank,History,The molecular structure of THC was discovered and synthesized by who?,1,Dr. Raphael Mechoulam,3;5;9;10,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,1,,3,3,Fill in the Blank,Cannabis Culture,"Who said: ""I Smoke a lot of pot when I write music.""",1,Lady Gaga,3;4;6,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,2,,7,3,Fill in the Blank,History,"In 70 AD, what civilzations texts listed cannabis as a cure for earache and a way to suppres sexual desires?",1,Romans,2;3,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,2,,10,3,Fill in the Blank,History,"What Persian physician stated in a published article written in 1025 A.D. that cannabis was an effective treatment for ailments such as gout, edema, and severe headaches?",1,Avicenna,3;7,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,3,,5,3,Fill in the Blank,Strains,The cross of Blue Cookies and Sunset Sherbert makes what strain?,1,Blue Sherbert,1;3;6;8,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,3,,4,3,Fill in the Blank,History,"In the Arthava-Veda a Hindu sacred text, cannabis is referred to as what?",1,sacred grass,2;7;11,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,4,,3,3,Fill in the Blank,History,This individual was the first commissioner of the United States Federal Bureau of Narcotics and helped to pass the Marihuana Tax Act of 1937.,1,Henry Anslinger,3;5;7;10,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,4,,8,3,Fill in the Blank,History,Carl Linnaeus referenced Cannabis sativa in his 1753 book by what name?,1,Species Plantarum,1;4;8;10,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,5,,9,3,Fill in the Blank,Strains,Which strain combines Gorilla Glue #4 and Thin Mint Girl Scout Cookies?,1,Gorilla Cookies,2;6;8,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,5,,4,3,Fill in the Blank,History,"In 1879, this country banned the importation of the cannabis plant.",1,Egypt,3;4,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,6,,4,3,Fill in the Blank,Strains,"Which strain is mixed with Chem's Sister, Sour Dubb and Chocolate Diesel?",1,Original Glue,1;5;6,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,6,,9,3,Fill in the Blank,Legal Cannabis Worldwide,"Which state declared cannabis a ""narcotic"" in 1931?",1,Texas,3,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,7,,6,3,Fill in the Blank,History,"Who was quoted saying: ""The primary reason to outlaw marijuana is its effect on the degenerate races.""",1,Henry Anslinger,1;5;6;14,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,7,,2,3,Fill in the Blank,Legal Cannabis Worldwide,Which state allowed up to life sentences for possession of marijuana in 1931?,1,Texas,4,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,7,,8,3,Fill in the Blank,Legal Cannabis Worldwide,Which state decriminalized cannabis in 1976?,1,Minnesota,2;3;8,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,8,,9,3,Fill in the Blank,Strains,Which strain combines Gorilla Glue #4 and Thin Mint Girl Scout Cookies?,1,Gorilla Cookies,1;5;8,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,8,,4,3,Fill in the Blank,Strains,"Which strain is mixed with Chem's Sister, Sour Dubb and Chocolate Diesel?",1,Original Glue,1;9;12,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,8,,2,3,Fill in the Blank,Science of Cannabis,The Molecular Cancer Therapeutics journal published findings that Cannabidiol has the ability to stop cancer by turning off what gene?,1,Id 1,1,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,8,,10,3,Fill in the Blank,History,"In 1300 A.D., Arab traders started to bring cannabis from India to what other country?",1,Eastern Africa,2;3;8,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,8,,7,3,Fill in the Blank,Science of Cannabis,_______ carries the chemical to the brain and other organs throughout the body.,1,Blood,3;5,1
,,,,,,3,Fill in the Blank,Cannabis Culture,"Who said: ""Hemp is of first necessity to the wealth and protection of the country.""",1,Thomas Jefferson,1;2;7;10,1
,,,,,,3,Fill in the Blank,Cannabis Culture,"Who was quoted saying: ""As for drugs, marijuana was the pharmeceutical of choice...""",1,Bill Gates,1;6;10,1
,,,,,,3,Fill in the Blank,Cannabis Culture,"Who was quoted saying: ""Sometimes you just gotta say fuck it and smoke a big ass joint.""",1,Tommy Chong,3;4;8,1
,,,,,,3,Fill in the Blank,Cannabis Culture,"Who said: ""Make the most you can of the Indian Hemp seed and sow it everywhere.""",1,George Washington,3;4;9;11,1
,,,,,,3,Fill in the Blank,History,"From 2000-1000 B.C., these religious people described cannabis as a ""source of happiness"" in their religious texts, and smoked during services and religious rituals.",1,Hindus,2;5,1
,,,,,,3,Fill in the Blank,History,The Nomadic Indo-European people who introduced cannabis to northern Europe.,1,Scythians,2;3;9,1)


def obfuscate(answer, chars = nil)
  hidden = "_ " * answer.size
  unless chars.nil?
    chars = chars.split(";")
    chars.each do |value|
      real_index = value.to_i-1;
      hidden[real_index] = answer[real_index]
    end
  end
  hidden
end


products = Product.where(internal_name: %w(caned cantrivia))

products.each do |product|
  ActsAsTenant.with_tenant(product) do
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      question = Trivia::HangmanAvailableQuestion.new(
        title: row["Question"],
        cooldown_period: 10,
        time_limit: 5,
        status: :published,
        complexity: row["Complexity"]
      )

      question.topic = Trivia::Topic.where(name: row["Topic"]).first
      question.save!
      question.available_answers.create(
        name: obfuscate(row["Answer 1"], row["Visible Characters"]),
        hint: row["Answer 1"],
        is_correct: true,
        status: :published
      )
    end
  end
end
