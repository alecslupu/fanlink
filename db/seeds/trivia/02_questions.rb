require 'csv'
csv_text = %Q(Games,Game Name,Game Description,Round Number,Round description,Question Order,Complexity,Question Type,Topic,Question,Number of Answers,Answer 1,Answer 2,Answer 3,Answer 4,Correct Answer,Imported
1,All About Cannabis,Think you know Cannabis?  Test your knowledge with this trivia game.,1,,3,1,Multiple Choice,Facts and Myths,Which of these plants is known to contain an abundant concentration of THC?,2,Hemp,Marijuana,,,2,
1,All About Cannabis,Think you know Cannabis?  Test your knowledge with this trivia game.,1,,5,1,Multiple Choice,Legal Cannabis Worldwide,Which statement is true for public consumption?,4,"It is strictly prohibited to smoke, vaporize or otherwise consume cannabis in public places","It is strictly prohibited to smoke cannabis in public places, however vaporization and edible consumption is permitted.",,,1,
1,All About Cannabis,Think you know Cannabis?  Test your knowledge with this trivia game.,1,,2,1,Multiple Choice,Cannabis Terms and Definitions,What slang term is used to describe a tobacco-wrapped cannabis cigarette?,4,Joint,Bowl,Blunt,Dab,3,
1,All About Cannabis,Think you know Cannabis?  Test your knowledge with this trivia game.,1,,6,1,Multiple Choice,Cannabis Culture,"The world met this infamous cannabis duo in 1978 when the released their first film together, who are they?",4,Snoop Dogg and Dr. Dre,James Franco and Seth Rogan,Cheech and Chong,Method Man and Redman,3,
1,All About Cannabis,Think you know Cannabis?  Test your knowledge with this trivia game.,2,,1,1,Multiple Choice,Facts and Myths,How many marijuana related deaths are there every year in the United States on average?,4,"It is hard to tell due to the fact that it is actually used by drinkers, cigarette smokers and opioid users, so a true number cannot be furnished yet.","10,000","20,000","30,000",1,
1,All About Cannabis,Think you know Cannabis?  Test your knowledge with this trivia game.,2,,2,1,True/False,Strains,24k Gold is an indica-dominant hybrid strain that is known for its citrus aroma and fruity taste.,2,True,False,,,1,
1,All About Cannabis,Think you know Cannabis?  Test your knowledge with this trivia game.,2,,3,1,Multiple Choice,Cannabis Culture,Which celebrity cannabis advocate released the cookbook ‘From Crook to Cook’ in October of 2018?,4,Wiz Khalifa,Snoop Dogg,Tommy Chong,Martha Stewart,2,
1,All About Cannabis,Think you know Cannabis?  Test your knowledge with this trivia game.,3,,3,1,Multiple Choice,Strains,What is Granddaddy Purple?,3,Sativa,Hybrid,Indica,,3,
1,All About Cannabis,Think you know Cannabis?  Test your knowledge with this trivia game.,3,,2,1,True/False,Facts and Myths,Women are over twice as likely as men to use marijuana in the United States.,2,True,False,,,2,
1,All About Cannabis,Think you know Cannabis?  Test your knowledge with this trivia game.,3,,4,1,True/False,Cannabis Culture,"Willie Nelson, the 86 year-old country crooner, smokes marijuana every single day.",2,True,False,,,1,
1,All About Cannabis,Think you know Cannabis?  Test your knowledge with this trivia game.,3,,6,1,True/False,Cannabis Culture,"Ice Cube and Ice T starred alongside each other in the cult classic film ""Friday"".",2,True,False,,,2,
1,All About Cannabis,Think you know Cannabis?  Test your knowledge with this trivia game.,4,,6,1,Multiple Choice,Science of Cannabis,What are some known medicinal benefits of the CBD cannabinoid?,4,All of the Above,"Can enhance the pain-relieving, nausea-reducing, and anti-cancer effects of THC.",Is an antipsychotic agent.,Helps to reduce or eliminate seizures.,1,
1,All About Cannabis,Think you know Cannabis?  Test your knowledge with this trivia game.,4,,2,1,Multiple Choice,Facts and Myths,Which of these plants is known to contain a very low concentraton of THC?,2,Hemp,Marijuana,,,1,
1,All About Cannabis,Think you know Cannabis?  Test your knowledge with this trivia game.,5,,4,1,Multiple Choice,History,Cannabis consumers everywhere come together on what day of the year to celebrate the plant and the culture?,4,April 20th (4/20),July 10th (7/10),April 1st (4/1),May 20th (5/20),1,
1,All About Cannabis,Think you know Cannabis?  Test your knowledge with this trivia game.,5,,3,1,Multiple Choice,History,Cannabis enthusiasts all over the world come together on what day every year to celebrate the plant?,4,May 20th,July 10th,April 22nd,None of the Above,4,
1,All About Cannabis,Think you know Cannabis?  Test your knowledge with this trivia game.,5,,2,1,Multiple Choice,Strains,________ strains deliver energizing effects and are most appropriate for day time use,2,Sativa,Indica,,,1,
1,All About Cannabis,Think you know Cannabis?  Test your knowledge with this trivia game.,6,,1,1,Multiple Choice,Science of Cannabis,"THC is the most famous of the cannabinoids, also the most researched.  THC is also known for its health properties which include which of the following?",4,All of the Above,Pain relief.,Helps to treat PTSD.,Effective sleep aid.,1,
1,All About Cannabis,Think you know Cannabis?  Test your knowledge with this trivia game.,6,,2,1,True/False,Methods of Consumption,Topicals provide localized relief for consumers with muscle aches and soreness.,2,True,False,,,1,
1,All About Cannabis,Think you know Cannabis?  Test your knowledge with this trivia game.,6,,5,1,True/False,Strains,Purple Kush is an indica strain.,2,True,False,,,1,
1,All About Cannabis,Think you know Cannabis?  Test your knowledge with this trivia game.,6,,6,1,True/False,Science of Cannabis,The two main ways to grow cannabis are indoor and outdoor.,2,True,False,,,1,
1,All About Cannabis,Think you know Cannabis?  Test your knowledge with this trivia game.,7,,4,1,Multiple Choice,Methods of Consumption,Which of the following is considered to be a tool needed to dab concentrates on a dab rig?,4,A torch,Lighter,Cannabis Flower,Hemp Wick,1,
1,All About Cannabis,Think you know Cannabis?  Test your knowledge with this trivia game.,7,,2,1,Multiple Choice,Strains,Which strain is generally used to relieve depression and fatigue?,2,Indica,Sativa,,,2,
1,All About Cannabis,Think you know Cannabis?  Test your knowledge with this trivia game.,7,,5,1,Multiple Choice,Cannabis Culture,This 2008 film starring James Franco and Seth Rogan is about a process server and his marijuana dealer as they are forced to flee from hitmen and a corrupt police officer after witnessing them commit a murder. ,4,Pineapple Express,Grandma's Boy,How High,Half Baked,1,
1,All About Cannabis,Think you know Cannabis?  Test your knowledge with this trivia game.,7,,1,1,Multiple Choice,History,The Controlled Substances Act that was signed by the United States Congress in 1970 grouped marijuana in what category of drugs?,4,Schedule I,Schedule II,Schedule III,All of the Above,1,
1,All About Cannabis,Think you know Cannabis?  Test your knowledge with this trivia game.,7,,3,1,Multiple Choice,Legal Cannabis Worldwide,Recreational use of marijuana is illegal in which of the following states?,4,Texas,Vermont,Massachusetts,Michigan,1,
1,All About Cannabis,Think you know Cannabis?  Test your knowledge with this trivia game.,8,,6,1,Multiple Choice,Legal Cannabis Worldwide,What United States Act initially made cannabis illegal in the United States?,4,1937 Marijuana Tax Act,Uniform State Narcotic Drug Act,Controlled Substances Act,Anti-Cannabis Act,1,
1,All About Cannabis,Think you know Cannabis?  Test your knowledge with this trivia game.,8,,1,1,Multiple Choice,Science of Cannabis,How long after smoking marijuana are mental and physical abilities weakened?,4,About 10 hours,About an hour,About 24 hours,About 4 or 5 hours,3,
1,All About Cannabis,Think you know Cannabis?  Test your knowledge with this trivia game.,8,,3,1,True/False,Facts and Myths,"The popularity of edibles also increases the chance of harmful reactions. Edibles take longer to digest and produce a high. Therefore, people may consume more to feel the effects faster, leading to dangerous results.",2,True,False,,,1,
1,All About Cannabis,Think you know Cannabis?  Test your knowledge with this trivia game.,8,,4,1,True/False,Legal Cannabis Worldwide,Medicinal use of marijuana is permitted in the state of Utah.,2,True,False,,,1,
1,All About Cannabis,Think you know Cannabis?  Test your knowledge with this trivia game.,8,,5,1,True/False,Strains,Green Crack is an indica strain.,2,True,False,,,2,
2,Cannabis Culture,Test your knowledge on Cannabis and the culture!,1,,2,1,Multiple Choice,Cannabis Freedom Fighters,"Tom Forcade was an American underground journalist and cannabis activist in the '70's, he founded what popular cannabis publication?",4,All of the Above,Cannabis Culture Magazine,Sensi Magazine,High Times,4,1
2,Cannabis Culture,Test your knowledge on Cannabis and the culture!,1,,5,1,Multiple Choice,Legal Cannabis Worldwide,Which of the following states legalized the use of medical marijuana in 2015?,4,Arkansas,Louisiana,Texas,New York,2,1
2,Cannabis Culture,Test your knowledge on Cannabis and the culture!,1,,3,1,True/False,Facts and Myths,Marijuana kills brain cells.,2,True,False,,,2,1
2,Cannabis Culture,Test your knowledge on Cannabis and the culture!,1,,6,1,True/False,Methods of Consumption,Dabbing is a form of vaporization.,2,True,False,,,1,1
2,Cannabis Culture,Test your knowledge on Cannabis and the culture!,2,,6,1,Multiple Choice,Legal Cannabis Worldwide,How many people are in U.S. prisons for non-violent marijuana-related offenses?,4,1.3 million,"About 240,000","About 40,000","About 500,000",3,1
2,Cannabis Culture,Test your knowledge on Cannabis and the culture!,2,,4,1,Multiple Choice,Cannabis Culture,"Who said, ""I used to smoke marijuana. But I’ll tell you something: I would only smoke it in the late evening. Oh, occasionally the early evening, but usually the late evening – or the mid-evening. Just the early evening, mid-evening and late evening. Occasionally, early afternoon, early midafternoon, or perhaps the late-mid-afternoon. Oh, sometimes the early-mid-late-early morning… But never at dusk.""",4,John Belushi,Kim Carnes,Steve Martin,Michael Jordan,3,1
2,Cannabis Culture,Test your knowledge on Cannabis and the culture!,2,,5,1,Multiple Choice,Facts and Myths,"Which of these plants has a short, bushy appearance, dense buds, and broad leaves?",2,Marijuana,Hemp,,,1,1
2,Cannabis Culture,Test your knowledge on Cannabis and the culture!,2,,3,1,Multiple Choice,Strains,Which is true for Sativa cannabis strains?,3,Sativa strains are appropriate for evening or night time use,"Sativa strains tend to be more sedating and relaxing, with full-body effects",Sativa strains deliver an energizing effect and are most appropriate for day time use,,3,1
2,Cannabis Culture,Test your knowledge on Cannabis and the culture!,2,,1,1,True/False,History,The DEA was created by US President Nixon to help enforce the Controlled Substances Act.,2,True,False,,,1,1
2,Cannabis Culture,Test your knowledge on Cannabis and the culture!,3,,2,1,Multiple Choice,Cannabis Culture,Which duo is best known for their comedy and bringing recreational marijuana use to the mainstream?,4,Cheech Marin & Tommy Chong,Will Smith & Martin Lawrence,Method Man & Redman,Jay & Silent Bob,1,1
2,Cannabis Culture,Test your knowledge on Cannabis and the culture!,3,,6,1,Multiple Choice,History,The first online purchase of marijuana was between students from what 2 colleges?,4,Stanford and MIT,Duke and University of North Carolina at Chapel Hill,"University of California, Berkeley and Harvard",Yale and Princeton,1,1
2,Cannabis Culture,Test your knowledge on Cannabis and the culture!,3,,3,1,True/False,Legal Cannabis Worldwide,"In Nevada, as of January 2017, adults over the age 21 can legally possess and purchase up to an ounce of marijuana flower and an eighth of marijuana concentrate at a time, for recreational use.",2,True,False,,,1,1
2,Cannabis Culture,Test your knowledge on Cannabis and the culture!,4,,6,1,Multiple Choice,Legal Cannabis Worldwide,Recreational use of marijuana is illegal in which of the following states?,4,Colorado,Kansas,Oregon,Maine,2,1
2,Cannabis Culture,Test your knowledge on Cannabis and the culture!,4,,4,1,True/False,Facts and Myths,Italy's Supreme Court ruled that Rastafarians can smoke and possess cannabis due to it being a sacrament to the religion.,2,True,False,,,1,1
2,Cannabis Culture,Test your knowledge on Cannabis and the culture!,4,,1,1,Multiple Choice,Cannabis Culture,Which celebrity duo is best known for their comedy and bringing recreational marijuana use to the mainstream?,4,Will Smith & Martin Lawrence,Cheech Marin & Tommy Chong,Method Man & Redman,Jay & Silent Bob,2,1
2,Cannabis Culture,Test your knowledge on Cannabis and the culture!,5,,6,1,Multiple Choice,Legal Cannabis Worldwide,Recreational use of marijuana is legal in which of the following states?,4,North Carolina,Pennsylvania,Oregon,New Jersey,3,1
2,Cannabis Culture,Test your knowledge on Cannabis and the culture!,5,,1,1,Multiple Choice,Methods of Consumption,This device works nearly the same as an e-cigarette.,2,Plug-in style Vaporizer,Vape pens,,,2,1
2,Cannabis Culture,Test your knowledge on Cannabis and the culture!,5,,2,1,True/False,Science of Cannabis,Cannabis flowers can be either male or female.,2,True,False,,,1,1
2,Cannabis Culture,Test your knowledge on Cannabis and the culture!,6,,3,1,Multiple Choice,Legal Cannabis Worldwide,Which persons are allowed entrance into a recreational dispensary?,4,A person under the age of 21,"Any person who has ""VOID"" marked on their government-issued photo ID",Any person exhibiting threatening or aggressive behavior,None of the Above,4,1
2,Cannabis Culture,Test your knowledge on Cannabis and the culture!,6,,2,1,True/False,Methods of Consumption,Edibles are cannabis-infused foods and drinks.,2,True,False,,,1,1
2,Cannabis Culture,Test your knowledge on Cannabis and the culture!,6,,4,1,True/False,Science of Cannabis,Higher THC levels may also means less of a risk for addiction if people are regularly exposing themselves to high doses.,2,True,False,,,2,1
2,Cannabis Culture,Test your knowledge on Cannabis and the culture!,6,,6,1,True/False,Strains,"$100 OG Kush is a 50/50 hybrid that has a sweet, earthy aroma.",2,True,False,,,1,1
2,Cannabis Culture,Test your knowledge on Cannabis and the culture!,7,,6,1,Multiple Choice,Cannabis Culture,"What 1998 movie starred Dave Chappelle, Jim Breuer and Harland Williams and is about a stoner in jail for accidentally killing a diabetic police horse. ",4,Grandma's Boy,Half Baked,Kid Cannabis,Smiley Face,2,1
2,Cannabis Culture,Test your knowledge on Cannabis and the culture!,7,,3,1,Multiple Choice,Science of Cannabis,The THC cannabinoid helps with a variety of different health conditions such as:,4,Insomnia,Glaucoma,Muslcle spasticity,All of the Above,4,1
2,Cannabis Culture,Test your knowledge on Cannabis and the culture!,7,,4,1,True/False,Strains,Kosher Kush is an indica strain.,2,True,False,,,1,1
2,Cannabis Culture,Test your knowledge on Cannabis and the culture!,8,,1,1,Multiple Choice,Cannabis Culture,"""I'm a joker, I'm a smoker, I'm a mid-night toker, I get my lovin' on the run"" is a line from what famous Steve Miller band song?",4,"""You Send Me""","""The Joker""","""Shu Ba Da Du Ma Ma""","""Quicksilver Girl""",2,1
2,Cannabis Culture,Test your knowledge on Cannabis and the culture!,8,,6,1,Multiple Choice,Methods of Consumption,Consumers who are trying cannabis edibles for the first time should do what to ensure they have an enjoyable exprience?,4,Take the entire package instead of the recommended dose.,Drink alcohol to intensify the effects.,Drive a car.,None of the Above,4,1
2,Cannabis Culture,Test your knowledge on Cannabis and the culture!,8,,2,1,True/False,History,U.S. President Donald Trump grows marijuana.,2,True,False,,,2,1
2,Cannabis Culture,Test your knowledge on Cannabis and the culture!,8,,5,1,Multiple Choice,Legal Cannabis Worldwide,Recreational use of marijuana is illegal in which of the following states?,4,Washington,Oregon,California,New Mexico,4,1
3,The Green Rush,All about the canna-BIZ,1,,1,1,Multiple Choice,Facts and Myths,Which President used to grow hemp before marijuana was made illegal in the U.S.?,4,James Madison,Abraham Lincoln,George Washington,Andrew Jackson,3,1
3,The Green Rush,All about the canna-BIZ,1,,2,1,True/False,Legal Cannabis Worldwide,Medical use of marijuana is permitted in the state of Delaware.,2,True,False,,,1,1
3,The Green Rush,All about the canna-BIZ,1,,5,1,True/False,Science of Cannabis,The psychoactive ingredient in cannabis is Cannabinol.,2,True,False,,,2,1
3,The Green Rush,All about the canna-BIZ,1,,6,1,True/False,Strains,Super Lemon Haze is an indica-dominant hybrid.,2,True,False,,,2,1
3,The Green Rush,All about the canna-BIZ,2,,6,1,Multiple Choice,Legal Cannabis Worldwide,Recreational use of marijuana is legal in which of the following states?,4,Alaska,Hawaii,Nebraska,Kansas,1,1
3,The Green Rush,All about the canna-BIZ,2,,2,1,Multiple Choice,Cannabis Culture,Marijuana prohibition is just the stupidest law possible… Just legalize it and tax it like we do liquor.,4,John F. Kennedy,Bob Hope,Sylvester Stallone,Morgan Freeman,4,1
3,The Green Rush,All about the canna-BIZ,2,,3,1,Multiple Choice,Cannabis Terms and Definitions,What does THC stand for?,4,Tetrahydrocannabivarin,Cannabigerol,Tetrahydrocannabinol,Cannabichromene,3,1
3,The Green Rush,All about the canna-BIZ,2,,4,1,True/False,Facts and Myths,"According to one national survey on drug use, each day approximately 6,000 Americans try marijuana for the first time.",2,True,False,,,1,1
3,The Green Rush,All about the canna-BIZ,3,,2,1,Multiple Choice,Science of Cannabis,What is the main psychoactive compound in marijuana?,4,Delta9-Tetrahydrocannabinol (THC),Cannabidiol (CBD),Myrcene,Linalool,1,1
3,The Green Rush,All about the canna-BIZ,3,,6,1,True/False,History,Hemp is a variety of the cannabis indica strain.,2,True,False,,,2,1
3,The Green Rush,All about the canna-BIZ,3,,5,1,True/False,Legal Cannabis Worldwide,Medicinal use of marijuana is permitted in the state of Idaho.,2,True,False,,,2,1
3,The Green Rush,All about the canna-BIZ,3,,1,1,Multiple Choice,Methods of Consumption,What is considered to be the flash vaporization of concentrates?,3,Vaping,Smoking,Dabbing,,3,1
3,The Green Rush,All about the canna-BIZ,4,,1,1,Multiple Choice,Facts and Myths,What percentage of American 12th graders use marijuana daily?,3,1.8%,2.8%,5.80%,,3,1
3,The Green Rush,All about the canna-BIZ,4,,2,1,Multiple Choice,Cannabis Terms and Definitions,"Cannabidiol is a cannabinoid within the cannabis plant the provides amazing health benefits such as helping with headaches, IBS, and PTSD.  What is the acronym most commonly associated with Cannabidiol?",4,CBDA,THC,CBD,None of the Above,3,1
3,The Green Rush,All about the canna-BIZ,4,,6,1,Multiple Choice,Methods of Consumption,Which is true for oral ingestion?,2,Oral ingestion offers consumers a method of consumption that requires the use of lungs,Oral ingestions offers consumers a method of consumption that does not require the use of lungs,,,2,1
3,The Green Rush,All about the canna-BIZ,4,,5,1,True/False,Facts and Myths,"In 2010, a mine collapsed in the country of Chile and the miners were trapped for 69 days. True or False, pornograpghy and marijuana were supplied to them to calm them down.",2,True,False,,,1,1
3,The Green Rush,All about the canna-BIZ,5,,1,1,Multiple Choice,Legal Cannabis Worldwide,What is the minimum age to purchase and consume cannabis in British Columbia?,4,18,19,20,21,2,1
3,The Green Rush,All about the canna-BIZ,5,,6,1,Multiple Choice,Legal Cannabis Worldwide,All of these are Cannabis rights organizations except for:,4,Al Anon,Alliance for Cannabis Therapeutics,Americans for Safe Access,Dagga Couple,1,1
3,The Green Rush,All about the canna-BIZ,5,,5,1,Multiple Choice,Cannabis Culture,"Which famous actress once said ""If everyone smoked weed, the world would be a better place?""",4,Cameron Diaz,Kirsten Dunst,Neicy Nash,Miley Cyrus,2,1
3,The Green Rush,All about the canna-BIZ,5,,2,1,True/False,Science of Cannabis,Cannabis is a complex plant with over 400 chemical entities.,2,True,False,,,1,1
3,The Green Rush,All about the canna-BIZ,6,,2,1,Multiple Choice,Facts and Myths,"Marijuana is known to contain more than 100 chemical compounds, what are these compounds called?",4,terpenes,cannabinoids,trichomes,None of the Above,2,1
3,The Green Rush,All about the canna-BIZ,6,,4,1,True/False,Science of Cannabis,Marijuana decreases your appetite.,2,True,False,,,2,1
3,The Green Rush,All about the canna-BIZ,6,,3,1,Multiple Choice,Legal Cannabis Worldwide,Which of the following states legalized the use of medical marijuana in 2016?,4,West Virginia,Georgia,Louisiana,Pennsylvania,4,1
3,The Green Rush,All about the canna-BIZ,7,,6,1,Multiple Choice,Cannabis Terms and Definitions,What does BHO stand for?,4,Budder Hashish Oil,Butane Hash Oil,Beautiful Hemp Oil,Big Hot Oil,2,1
3,The Green Rush,All about the canna-BIZ,7,,5,1,True/False,Legal Cannabis Worldwide,Medicinal use of marijuana is permitted in the state of Nevada.,2,True,False,,,1,1
3,The Green Rush,All about the canna-BIZ,7,,1,1,True/False,Science of Cannabis,CBD treats a variety of disorders and diseases.,2,True,False,,,1,1
3,The Green Rush,All about the canna-BIZ,7,,2,1,True/False,Strains,Blue Cheese is a sativa strain.,2,True,False,,,2,1
3,The Green Rush,All about the canna-BIZ,8,,1,1,Multiple Choice,Cannabis Culture,"Two of the most recognized celebrity stoners starred alongside each other in the movie ""How High"", who are they?",4,Cheech Marin and Tommy Chong,James Franco and Jonah Hill,Method Man and Redman,Shawn Wayans and Marlon Wayans,3,1
3,The Green Rush,All about the canna-BIZ,8,,4,1,True/False,Legal Cannabis Worldwide,Medicinal use of marijuana is permitted in the state of West Virginia.,2,True,False,,,1,1
3,The Green Rush,All about the canna-BIZ,8,,5,1,True/False,Methods of Consumption,Joints are cannabis rolled in cigar paper made from tobacco plants and contain nicotine.,2,True,False,,,2,1
4,It's All About The Ganja,Ganja Trivia,1,,6,1,Multiple Choice,Legal Cannabis Worldwide,Recreational use of marijuana is legal in which of the following states?,4,Idaho,New York,Nevada,Montana,3,1
4,It's All About The Ganja,Ganja Trivia,1,,2,1,Multiple Choice,Methods of Consumption,"Which method of consumption is best used for applying lotions, balms and salves?",3,Inhalation,Topicals,Ingestion,,2,1
4,It's All About The Ganja,Ganja Trivia,1,,1,1,Multiple Choice,Facts and Myths,An Indian milkshake whose main ingredient is marijuana.,4,Tiger's Blood,Bhang,Murg Makhani,Rogan Josh,2,1
4,It's All About The Ganja,Ganja Trivia,2,,1,1,Multiple Choice,Cannabis Culture,"Who said, ""That is not a drug, it’s a leaf.""",4,Arnold Schwarzenegger,Taylor Swift,Brad Pitt,Jeff Sessions,1,1
4,It's All About The Ganja,Ganja Trivia,2,,5,1,True/False,Legal Cannabis Worldwide,Driving under the influence of marijuana is legal in recreational cannabis states.,2,True,False,,,2,1
4,It's All About The Ganja,Ganja Trivia,2,,6,1,True/False,Science of Cannabis,THC gets you high.,2,True,False,,,1,1
4,It's All About The Ganja,Ganja Trivia,3,,5,1,Multiple Choice,Methods of Consumption,"Which of these cannabis edibles tends to take a big longer to activate within the body, but can produce a longer lasting effect?",4,Lollipops,None of the Above,Tinctures and Oils,Gum,2,1
4,It's All About The Ganja,Ganja Trivia,3,,4,1,True/False,Science of Cannabis,Marijuana is known to treat migraines.,2,True,False,,,1,1
4,It's All About The Ganja,Ganja Trivia,3,,1,1,True/False,Strains,Lemon Haze is a hybrid strain.,2,True,False,,,2,1
4,It's All About The Ganja,Ganja Trivia,4,,2,1,Multiple Choice,Cannabis Culture,"Which of these US Presidents was quoted saying, ""When I was a kid I inhaled frequently.  That was the point.""",4,George W. Bush,Bill Clinton,Barack Obama,Ronald Reagan,3,1
4,It's All About The Ganja,Ganja Trivia,4,,3,1,True/False,Facts and Myths,Cannabis has been reported to cause fatal overdose in humans.,2,True,False,,,2,1
4,It's All About The Ganja,Ganja Trivia,4,,4,1,True/False,Legal Cannabis Worldwide,"It is illegal for anyone under the age of 21 to buy, possess, or use retail marijuana in Nevada.",2,True,False,,,1,1
4,It's All About The Ganja,Ganja Trivia,4,,5,1,True/False,Legal Cannabis Worldwide,"On Prince Edward Island, Canada you will only be able to consume cannabis in a private residence.",2,True,False,,,1,1
4,It's All About The Ganja,Ganja Trivia,5,,2,1,Multiple Choice,Legal Cannabis Worldwide,Which is true for customer confidentiality in the United States?,4,All personal information collected is confidential and private,"Personal information will be released to any third party, excluding the customer or patient's written consent","Personal information will be released to any third party, excluding customer or patient's written consent",All personal information collected is not considered confidential or private,1,1
4,It's All About The Ganja,Ganja Trivia,5,,4,1,Multiple Choice,Legal Cannabis Worldwide,Recreational use of marijuana is legal in which of the following states?,4,Connecticut,Colorado,Delaware,Illinois,2,1
4,It's All About The Ganja,Ganja Trivia,5,,1,1,Multiple Choice,Cannabis Culture,Which actor won Stoner of the Year at The High Times Stonys in 2008?,4,Tommy Chong,Doug Benson,James Franco,Bill Murray,3,1
4,It's All About The Ganja,Ganja Trivia,5,,3,1,True/False,Methods of Consumption,Joints are cannabis rolled in a rolling paper.,2,True,False,,,1,1
4,It's All About The Ganja,Ganja Trivia,6,,5,1,Multiple Choice,Cannabis Culture,"Which 1998 cannabis cult classic film starred Jim Breuer, Dave Chappelle, and Guillermo Diaz?",4,"""Fear and Loathing in Las Vegas""","""The Wash""","""How High""","""Half Baked""",4,1
4,It's All About The Ganja,Ganja Trivia,6,,4,1,Multiple Choice,Legal Cannabis Worldwide,What state was the first state to legalize medical cannabis?,4,Nevada,Washington,California,Oregon,3,1
4,It's All About The Ganja,Ganja Trivia,6,,6,1,True/False,Cannabis Terms and Definitions,"""Da kine"" is a term often used to describe cannabis flower.",2,True,False,,,1,1
4,It's All About The Ganja,Ganja Trivia,6,,1,1,True/False,Legal Cannabis Worldwide,"You must be at least 21 years of age or older to consume, purchase, and possess cannabis in the Canadian province of Manitoba.",2,True,False,,,2,1
4,It's All About The Ganja,Ganja Trivia,6,,2,1,True/False,Methods of Consumption,Inhalation is the most popular method of cannabis consumption.,2,True,False,,,1,1
4,It's All About The Ganja,Ganja Trivia,7,,4,1,Multiple Choice,Facts and Myths,"In order to overdose from cannabis, an individual would need to consume how many times the average amount in a very short period to actually die? ",4,"10,000",100,"40,000",None of the Above,3,1
4,It's All About The Ganja,Ganja Trivia,7,,6,1,Multiple Choice,Legal Cannabis Worldwide," The Compassionate Use Act of 1996, is a California law allowing the use of medical cannabis that was put on the ballot as...",3,Proposition 415,Proposition 215,Proposition 400,,2,1
4,It's All About The Ganja,Ganja Trivia,7,,5,1,Multiple Choice,History,Under what US President was the Drug Enforcement Agency (DEA) created?,4,Richard Nixon,John F. Kennedy,Jimmy Carter,Ronald Reagan,1,1
4,It's All About The Ganja,Ganja Trivia,7,,3,1,Multiple Choice,Cannabis Culture,"""Herb is the healing of a nation; alcohol is the destruction."" is a famous quote by what musician?",4,Snoop Dogg,Peter Tosh,Bob Marley,Seth Rogan,3,1
4,It's All About The Ganja,Ganja Trivia,8,,2,1,Multiple Choice,Cannabis Culture,"This cannabis advocate started their career in Washington, D.C. shortly after they dropped out of school.  Joining the Youth International Party where they organized July 4 smoke-ins to protest the prohibition of marijuana.  Who is this advocate?",4,Jack Herer,Mary Jane Rothbun,Steve DeAngelo,Dennis Peron,3,1
4,It's All About The Ganja,Ganja Trivia,8,,5,1,Multiple Choice,Strains,"________ strains tend to be more sedating and relaxing, with full-body effects, and are appropriate for night time use.",2,Sativa,Indica,,,2,1
4,It's All About The Ganja,Ganja Trivia,8,,3,1,True/False,Legal Cannabis Worldwide,Marijuana is legalized in the U.S. state of Maine.,2,True,False,,,1,1
4,It's All About The Ganja,Ganja Trivia,8,,4,1,True/False,Methods of Consumption,Tinctures are a liquid cannabis extract.,2,True,False,,,1,1
`,,,,,,1,True/False,Legal Cannabis Worldwide,"It is legal to grow, sell and consume cannabis in Uruguay.",2,True,False,,,1,1
,,,,,,1,Multiple Choice,Facts and Myths,The Insurance Institute for Highway Safety analyzed insurance claims for vehicle collisions filed between January 2012 and October 2016. They found the states that had recently legalized marijuana had what percentage of higher collision claims then the states that were illegal?,4,3%,5%,10%,15%,1,1
,,,,,,1,Multiple Choice,Facts and Myths,Jamestown was a colony Virginia. In what year did a colony law declare that all settlers must grow Indian hemp?,4,1619,1519,1719,1789,1,1
,,,,,,1,Multiple Choice,Facts and Myths,Marijuana has been used to fight opioid addiction due to the overdose ratio. Approximately how many opioid deaths by overdose were recorded in 2017?,4,"90,003","15,876","70,237","52,504",3,1
,,,,,,1,Multiple Choice,Legal Cannabis Worldwide,Data analytics firm BDS Analytics calculated that how many people were employed by the U.S. cannabis industry in 2017.,4,"121,000","21,000","51,000","75,000",1,1
,,,,,,1,Multiple Choice,Cannabis Culture,In which movie do the characters Silas and Jamal meet in the parking lot before taking their Testing for Higher Learning (THC) exam?,4,"""How High""","""Cheech and Chong's Next Movie""","""Dude Where's My Car""","""Harold and Kumar Go To White Castle""",1,1
,,,,,,1,Multiple Choice,Cannabis Culture,"In 1993, rappers Mista Grimm, Warren G., and Nate Dogg collaborated for which cannabis themed song that was featured on the Poetic Justice soundtrack?",4,"""Situation: Grimm""","""Gin and Juice""","""Indo Smoke""","""I Got 5 On It""",3,1
,,,,,,1,Multiple Choice,Cannabis Culture,"Originally released in 1983 by The Toyes, this classic stoner song stuck its place in cannabis culture by being featured on Sublime's debut album 40oz. to Freedom.",4,"""Smoke Two Joints""","""We're Only Gonna Die""","""Waiting for My Ruca""","""Badfish""",1,1
,,,,,,1,Multiple Choice,Cannabis Culture,American jazz musician Cab Calloway performed what song featured in the film International House about a man who favored marijuana cigarettes?,3,"""Thank Heaven For You""","""Reefer Man""","""My Bluebird's Singing the Blues""",,2,1
,,,,,,1,Multiple Choice,Facts and Myths,"According to an August 2017 survey from the independent Quinnipiac University, what percentage of Americans supported the legalization of medical marijuana?",4,12%,76%,94%,32%,3,1
,,,,,,1,Multiple Choice,Legal Cannabis Worldwide,"In Canada, adults who are ___ years of age or older are legally able to possess, buy and grow cannabis.",2,18,21,,,1,1
,,,,,,1,Multiple Choice,Legal Cannabis Worldwide,"In the Canadian province of New Brunswick, you must be how old to consume, purchase, possess, and grow cannabis?",4,19,18,21,None of the Above,1,1
,,,,,,1,Multiple Choice,Legal Cannabis Worldwide,In what year did Mississippi decriminalize cannabis?,4,1979,1977,1980,1976,2,1
,,,,,,1,Multiple Choice,Legal Cannabis Worldwide,In what year did New York decriminalize cannabis?,4,1981,1990,1977,1976,3,1
,,,,,,1,Multiple Choice,Legal Cannabis Worldwide,In what year did North Carolina decriminalize cannabis?,4,1985,1992,1977,1978,3,1
,,,,,,1,Multiple Choice,Legal Cannabis Worldwide,In what year did Nebraska decriminalize cannabis?,4,1999,1979,1985,1978,4,1
,,,,,,1,Multiple Choice,Legal Cannabis Worldwide,"In Ontario, Canada you can legally possess how many lants in your household?",4,2,1,4,6,3,1
,,,,,,1,Multiple Choice,Science of Cannabis,Recent data suggest that what percent of those who use marijuana may have some degree of marijuana use disorder.,3,25%,30%,10%,,2,1
,,,,,,1,Multiple Choice,Legal Cannabis Worldwide,What are the maximum U.S. federal sentencing guidelines for a first-time offense of possession of any amount of marijuana?,4,5 years in prison and $5000 in fines,30 days in jail,"1 year in prison and $1,000 in fines",6 months in prison and $500 in fines,3,1
,,,,,,1,Multiple Choice,Cannabis Culture,"Which of these artists have songs with, ""Mary Jane"" in the title?",4,All of the Above,Creeence Clearwater Revival,Rick James,Run D.M.C.,3,1
,,,,,,1,Multiple Choice,Cannabis Terms and Definitions,Which of the following terms are slang for cannabis?,4,All of the Above,Ganja,Reefer,Bud,1,1
,,,,,,1,Multiple Choice,Cannabis Culture,Which U.S. President's name was used for a popular Indica strain?,4,Barack Obama,George W Bush,Bill Clinton,Richard Nixon,1,1
,,,,,,1,Multiple Choice,Cannabis Culture,"The High Times Cannabis Cup, beginning in 1988 and typically taking place in San Bernardino, CA, technically started out as a cannabis festival in what European city?",4,Berlin,Vienna,Amsterdam,Stockholm,3,1
,,,,,,1,Multiple Choice,Cannabis Culture,"Who said, ""When I was in England, ""I experimented with marijuana a time or two, and didn't like it. I didn't inhale and I didn't try it again.""",4,Bill Clinton,Tiger Woods,Richard Nixon,Serena Williams,1,1
,,,,,,1,Multiple Choice,Cannabis Culture,"Which of these US Presidents was quoted saying, ""I tried marijuana once.  I did not inhale.""",4,Bill Clinton,George W. Bush,Barack Obama,Jimmy Carter,1,1
,,,,,,1,Multiple Choice,Cannabis Culture,"This Cornell University graduate has appeared in five HBO specials, has been a guest on both Letterman and Leno, and also sits on the advisory board for the National Organization for the Reform of Marijuana Laws (NORML).",4,Bill Maher,None of the Above,Jeff Foxworthy,Dave Chappelle,1,1
,,,,,,1,Multiple Choice,Facts and Myths,Which one one these is NOT a brand of marijuana products?,4,BNP Paribas,BNP Paribas,Marley Natural,The Goodship Company,2,1
,,,,,,1,Multiple Choice,Methods of Consumption,What device is most commonly used to consume cannabis concentrates?,4,Bong,Bubbler,Pipe,Dab rig,4,1
,,,,,,1,Multiple Choice,Legal Cannabis Worldwide,Recreational use of marijuana is legal in which of the following states?,4,California,Arizona,New Mexico,Wyoming,1,1
,,,,,,1,Multiple Choice,Cannabis Culture,"What high school classmate was Snoop Dogg referring to when he told George Lopez, ""I might have sold her some of that white girl weed""?",4,Cameron Diaz,Lindsay Lohan,Drew Barrymore,Jennifer Garner,4,1
,,,,,,1,Multiple Choice,Legal Cannabis Worldwide,"In 2003, what country became the first country in North America to offer medical marijuana to pain-suffering patients?",4,Canada,Mexico,United States of America,Greenland,1,1
,,,,,,1,Multiple Choice,Cannabis Terms and Definitions,What does CBD stand for?,4,Cannabidiol,Tetrahydrocannabinol,Cannabidivarin,Cannabigerol,1,1
,,,,,,1,Multiple Choice,Science of Cannabis,________ are organic compounds that produce distinctive tastes and smells in different strains of both cannabis and beer hops.,3,Cannabinoids,Trichomes,Terpenes,,3,1
,,,,,,1,Multiple Choice,Science of Cannabis,"What is the proper, biological name of marijuana?",4,Cannabis Erotica,Cannabis Tetris,Cannabis Sativa,Cannabis Erronis,3,1
,,,,,,1,Multiple Choice,Science of Cannabis,"Which receptor is mainly found in the brain, lungs, liver and kidneys?",2,CB1,CB2,,,1,1
,,,,,,1,Multiple Choice,Science of Cannabis,Which receptor is mainly found in the immune system?,2,CB1,CB2,,,2,1
,,,,,,1,True/False,Science of Cannabis,Which compound is the main psychoactive part of cannabis?,4,CBD,CBG,THC,THCV,3,1
,,,,,,1,Multiple Choice,Science of Cannabis,Which one of the following is NOT an effect of smoking marijuana?,4,Changes in memory,Difficulty with hearing,Changes in mood,Changes in appetite,2,1
,,,,,,1,Multiple Choice,History,Cannabis was used medicinally in which of these ancient civilizations?,4,Chinese,Egyptians,Romans,All of the Above,4,1
,,,,,,1,Multiple Choice,Cannabis Culture,"What worldwide superstar said ""I smoke a lot of pot when I write music.""",4,Christina Aguilera,Britney Spears,Lady Gaga,Snoop Dogg,3,1
,,,,,,1,Multiple Choice,Facts and Myths,What is the most commonly used illicit drug in the United States.,4,Cocaine,Marijuana,Valium,Percocet,2,1
,,,,,,1,Multiple Choice,Science of Cannabis,You should be able to determine the _____ on your plant between four and six weeks by looking at the pre-flowers.,4,Color,Height,Price,Sex,4,1
,,,,,,1,Multiple Choice,Methods of Consumption,Which inhalation method is best used in effort to avoid inhalaing irritants and potential carcinogens?,4,Combustion (Smoking),Edibles,Vaporization,Sublinguals,3,1
,,,,,,1,Multiple Choice,Methods of Consumption,Which inhalation methohd is best used in effort to avoid inhaling irritants or potential carcinogens?,4,Combustion (smoking),Edibles,Vaporization,Sublinguals,3,1
,,,,,,1,Multiple Choice,Methods of Consumption,Which of these cannabis edibles are considered to be a sublingual edible?,4,Cookies,Brownies,Infused Chips,None of the Above,4,1
,,,,,,1,Multiple Choice,Methods of Consumption,This device is a long tubular water pipe with a bowl attached on its one end,4,Dab Rig,Hookah,Bowl,Bong,4,1
,,,,,,1,Multiple Choice,Methods of Consumption,Which device listed is the combination of a pipe and a bong?,4,Dab rig,Bubbler,Grinder,Joint,2,1
,,,,,,1,Multiple Choice,Cannabis Terms and Definitions,Which of the following is a slang term used to refer to the dried flower of the cannabis plant?,4,Dank,Nug,Reefer,Weed,2,1
,,,,,,1,Multiple Choice,Cannabis Terms and Definitions,This slang term is used to describe the pungent aroma that the cannabis flower gives off.,4,Dank,Chronic,Herb,Bud,1,1
,,,,,,1,Multiple Choice,Science of Cannabis,Which one of these effects is NOT a symptom of marijuana?,4,Delusions,Psychosis,The Bends,Altered Sense of Time,3,1
,,,,,,1,Multiple Choice,Cannabis Culture,"In 1995, what bay area rap group coined the term ""I Got Five On It"" with their worldwide hit by the same name?",4,Digiatl Underground,Hieroglyphics,The Luniz,Souls of Mischief,3,1
,,,,,,1,Multiple Choice,Strains,501st OG is typically recommended by budtenders to use during what time of day?,3,Early morning,After lunch,Evening,,3,1
,,,,,,1,Multiple Choice,Science of Cannabis,"Indoor cannabis growers have to replace sunlight, what type of light(s) are typically used indoors?",4,Flourescent grow lights,LED grow lights,HID grow lights,All of the Above,4,1
,,,,,,1,Multiple Choice,Cannabis Culture,"In the 1933 film International House what American jazz musician performed the song ""Reefer Man""?",4,George Burns,Gracie Allen,W.C. Fields,Cab Calloway,4,1
,,,,,,1,Multiple Choice,Strains,Which U.S. President's name was used for a popular Indica strain?,4,George W Bush,Barack Obama,Bill Clinton,Donald Trump,2,1
,,,,,,1,Multiple Choice,Methods of Consumption,Pipes used to consume cannabis can be made of what material?,4,Glass,Metal,Wood,All of the Above,4,1
,,,,,,1,Multiple Choice,Strains,Which of the following strains is a sativa?,4,Grandaddy Purple,Blue Cheese,LA Confidential,Sour Diesel,4,1
,,,,,,1,Multiple Choice,Cannabis Culture,Which celebrity cannabis advocate co-hosts Potluck Dinner Party show with Snoop Dogg ?,4,Guy Fieri,Rachel Ray,Martha Stewart,Gordon Ramsey,3,1
,,,,,,1,Multiple Choice,Cannabis Culture,Which celebrity cannabis advocate co-hosts 'Potluck Dinner Party' with Snoop Dogg?,4,Guy Fieri,Rachel Ray,Martha Stewart,Gordon Ramsey,3,1
,,,,,,1,Multiple Choice,Cannabis Culture,Which stoner film did actor and cannabis activist Seth Rogen star in?,4,Half Baked,This is the End,Evil Bong,Super High Me,2,1
,,,,,,1,Multiple Choice,Cannabis Culture,Harold & Kumar rode a cheetah in which one of their popular films?,3,Harold & Kumar Go to White Castle,A Very Harold & Kumar 3D Christmas,Harold & Kumar Escape from Guantanamo Bay,,1,1
,,,,,,1,Multiple Choice,Methods of Consumption,What is the name of a filtered water pipe used to smoke marijuana?,4,Hash Pipe,Bradley,Water Flow,Bong,4,1
,,,,,,1,Multiple Choice,Cannabis Culture,"What television series is about a single-mother named Nancy whose husband died, so she starts to sell her own strain of marijuana called ""MILF"".",4,High Maintenence,Weeds,Bong Appétit,Mary Jane,2,1
,,,,,,1,Multiple Choice,Cannabis Culture,Which item was Bob Marley NOT buried with?,4,His Bible,His Guitar,A Bud of Marijuana,His Crucifix,4,1
,,,,,,1,Multiple Choice,Science of Cannabis,"Positive side effects of cannabis can include feeling happy, euphoric, or even relaxed.  There are some negative side effects which include paranoia, anxiety, and __________.",4,Hunger,Focus,Relaxation,Dizziness,4,1
,,,,,,1,Multiple Choice,Science of Cannabis,The temporary side effects of THC include:,4,Increased heart rate,Dry mouth,Red eys,All of the Above,4,1
,,,,,,1,Multiple Choice,History,Cannabis seeds were used as a food source in what country as early as 6000 B.C.?,4,India,Japan,Russia,China,4,1
,,,,,,1,Multiple Choice,Legal Cannabis Worldwide,Recreational use of marijuana is legal in which of the following states?,4,Indiana,Michigan,Minnesota,North Dakota,2,1
,,,,,,1,Multiple Choice,Strains,Which strain is generally used to relieve depression and fatigue?,2,Indica,Sativa,,,1,1
,,,,,,1,Multiple Choice,Strains,Which strain is generally used to relieve pain and insomnia?,2,Indica,Sativa,,,1,1
,,,,,,1,Multiple Choice,Strains,Which is true for Indica cannabis strains?,3,"Indica strains tend to be more sedating and relaxing, with full-body effects",Indica strains deliver an energizing effect,Indica strains are most appropriate for day time use,,1,1
,,,,,,1,Multiple Choice,Strains,Which is true for Indica strains?,3,"Indica strains tend to be more sedating and relaxing, with full-body effects",Indica strains deliver an energizing effect,Indica strains are most appropriate for day time use,,1,1
,,,,,,1,Multiple Choice,Facts and Myths,What is the primary reason for the growth of hemp?,2,Industrial purposes,Consumer purposes,,,1,1
,,,,,,1,Multiple Choice,Methods of Consumption,What method of consumption is the most discreet?,3,Ingestion,Vaporizing,Smoking flower,,1,1
,,,,,,1,Multiple Choice,Methods of Consumption,It is best to recommend which of the following methods to a customer that wants to avoid smoking cannabis?,2,Ingestion,Inhalation,,,1,1
,,,,,,1,Multiple Choice,Methods of Consumption,Which method of consumption is best for consuming edibles?,3,Ingestion,Topicals,Inhalation,,1,1
,,,,,,1,Multiple Choice,Legal Cannabis Worldwide,Which statement is true for public consumption of marijuana in the United States?,2,"It is strictly prohibited to smoke, vaporize or consume cannabis in public places","It is strictly prohibited to smoke cannabis in public places, however vaporization and edible consumption is permitted",,,1,1
,,,,,,1,Multiple Choice,Strains,Which strain won the 1st High Times Cannabis Cup in 1988?,4,Jack Herer,Blueberry,White Widow,Skunk #1,4,1
,,,,,,1,Multiple Choice,Methods of Consumption,"What product is made by soaking cannabis flower in hash oil, than coated in kief and dried until ready for consumption?",4,Jelly Hash,Honeycomb,Shatter,Caviar,4,1
,,,,,,1,Multiple Choice,Cannabis Culture,"Who said, ""Never smoke pot before there's the possibility of having to talk to a hundred million people,""  when speaking about accepting an Oscar at the the 1991 Academy Awards?",4,Kevin Costner,Whoopi Goldberg,Jeremy Irons,Joe Pesci,2,1
,,,,,,1,Multiple Choice,Cannabis Culture,Which film won Best Stoner Movie at The High Times Stonys in 2002?,4,Lords of Dogtown,How High,Harold & Kumar Go to White Castle,Grandma's Boy,2,1
,,,,,,1,Multiple Choice,Science of Cannabis,What is amotivational syndrome?,4,Loss of interest in goals and life outside of marijuana use.,Increased aggression with marijuana use.,Increased manic depression due to little marijuana use.,A hereditary bowel disease caused by marijuana.,1,1
,,,,,,1,Multiple Choice,Cannabis Culture,"Hailing from Palmdale, CA, this rapper hit the scene with the song ""Because I Got High"" in 2000, and has been performing for stoned crowds across the globe since.",4,Ludacris,Afro Man,Method Man,Redman,2,1
,,,,,,1,Multiple Choice,Legal Cannabis Worldwide,"In 1996, what U.S. state was the first to legalize medical cannabis?",4,Maine,California,Colorado,Oregon,2,1
,,,,,,1,Multiple Choice,Facts and Myths,"Which of these plants grows tall, has skinny leaves that are towards the top?",2,Marijuana,Hemp,,,2,1
,,,,,,1,Multiple Choice,Cannabis Terms and Definitions,Which of the following is another term for marijuana?,4,Mary Jane,Reefer,All of the Above,Dope,3,1
,,,,,,1,Multiple Choice,Methods of Consumption,"Which of these duo's made Bambú rolling papers famous with their album ""Big Bambu""?",4,Method Man and Redman,Snoop Dogg and Dr. Dre,Wiz Khalifa and Snoop Dogg,Cheech and Chong,4,1
,,,,,,1,Multiple Choice,Cannabis Culture,Which music festival served as the culmination of the hippie revolution in the USA?,4,Monterey Pop Festival,Newport Folk Festival,Woodstock Festival,Altamont Speedway Free Festival,3,1
,,,,,,1,Multiple Choice,Legal Cannabis Worldwide,In 1976 which state decriminalized cannabis?,4,Nebraska,California,Minnesota,New York,3,1
,,,,,,1,Multiple Choice,Legal Cannabis Worldwide,Recreational use of marijuana is legal in which of the following states?,4,Nebraska,South Dakota,Washington,Georgia,3,1
,,,,,,1,Multiple Choice,Legal Cannabis Worldwide,Is it Legal to Use/Possess Marijuana in Jamaica for recreational purposes?,3,"No, it is not legal.","Yes, it is legal.",It is only legal in some parts of the country.,,1,1
,,,,,,1,Multiple Choice,Cannabis Terms and Definitions,What is the acronym commonly used to describe butane hash oil?,4,None of the Above,THC,BHO,CBD,3,1
,,,,,,1,Multiple Choice,Cannabis Culture,"After his murder, members of who's music group mixed his ashes with marijuana and smoked the concoction?",4,Notorious B.I.G.,Soulja Slim,Tupac Shakur,Nipsey Hussle,3,1
,,,,,,1,Multiple Choice,Legal Cannabis Worldwide,"In 1990, what state re-criminalized cannabis restoring criminal penalties for possession of any amount of cannabis, by voter initiative?",4,Oregon,Alaska,New York,Mississippi,2,1
,,,,,,1,Multiple Choice,Legal Cannabis Worldwide,Recreational use of marijuana is illegal in which of the following states?,4,Oregon,Nevada,Florida,Alaska,3,1
,,,,,,1,Multiple Choice,Cannabis Culture,"Who said, ""I smoked some weed and that's how I finished Izzo""?",4,P-Diddy,Jay-Z,Eminem,Cardi-B,2,1
,,,,,,1,Multiple Choice,Strains,Which strain won the 10th High Times Cannabis Cup in 1997?,4,Peace Maker,Sweet Tooth,Super Silver Haze,,1,1
,,,,,,1,Multiple Choice,Legal Cannabis Worldwide,Which of the following is considered confidential customer information?,4,Purchase History,Customer Name,Medical Information ,All of the Above,4,1
,,,,,,1,Multiple Choice,Cannabis Culture,Which stoner film documents a comedian who consumes cannabis every day for 30 days in a row?,4,Reefer Madness,The Culture High,420 - The Documentary,Super High Me,4,1
,,,,,,1,Multiple Choice,Methods of Consumption,The resin that is left behind in a dab rig is called what?,4,resin,rosin,hash oil,reclaim,4,1
,,,,,,1,Multiple Choice,Cannabis Culture,"Which famous musician told Rolling Stone in 1982 ""I don't buy ounces, I buy pounds.""?",4,Rick James,Ozzy Ozbourne,Willie Nelson,Bob Marley,1,1
,,,,,,1,Multiple Choice,Cannabis Culture,Which celebrity was spotted smoking marijuana while on vacation in Hawaii in 2012?,4,Rihanna,Tommy Chong,Miley Cyrus,Wiz Khalifa,1,1
,,,,,,1,Multiple Choice,Cannabis Culture,Which celebrity was spotted smoking marijuana while on vacation in Hawaii in 2012?,4,Rihanna,Tommy Chong,Miley Cyrus,Wiz Khalifa,1,1
,,,,,,1,Multiple Choice,Strains,Which celebrity shares their name with a cannabis strain?,4,Rihanna,Miley Cyrus,Wiz Khalifa,Justin Bieber,3,1
,,,,,,1,Multiple Choice,Science of Cannabis,What is NOT a subspecies of cannabis,4,Sativa,Aurorealis,Indica,Ruderalis,2,1
,,,,,,1,Multiple Choice,Strains,Which strain is generally used to relieve pain and insomnia?,2,Sativa,Indica,,,2,1
,,,,,,1,Multiple Choice,Strains,"Which strain tends to be more sedating and relaxing, with full-body effects and is appropriate for night time use?",2,Sativa,Indica,,,2,1
,,,,,,1,Multiple Choice,Strains,Which strain tends to deliver energizing effects and is most appropriate for day time use?,2,Sativa,Indica,,,1,1
,,,,,,1,Multiple Choice,Strains,Which is true for Sativa strains?,3,"Sativa strains tend to be more sedating and relaxing, with full-body effects",Sativa strains are appropriate for night time use,Sativa strains deliver an energizing effects and is most appropriate for day time use,,3,1
,,,,,,1,Multiple Choice,Science of Cannabis,The cannabinoid CBD helps to aid in a variety of different health conditions including:,4,Seizures,Migraines,Anxiety,All of the Above,4,1
,,,,,,1,Multiple Choice,Cannabis Culture,"This rockstar is a breast cancer survivor and was quoted saying: ""Instead of taking five or six of the prescriptions, I decided to go the natural route and smoke marijuana.""",4,Sheryl Crow,Angelina Jolie,Melissa Etheridge,Shania Twain,3,1
,,,,,,1,Multiple Choice,Cannabis Culture,"Who sang the 2001 song, ""Because I Got High""?",4,Snoop Dogg,G-Eazy,Afroman,Lil' Wayne,3,1
,,,,,,1,Multiple Choice,Cannabis Terms and Definitions,What slang term is used to describe a joint or blunt rolled with a mixture of tobacco and dried cannabis flower?,3,Spliff,Dab,A wood,,1,1
,,,,,,1,Multiple Choice,Cannabis Culture,"What classic rock band gave us the classic toking song ""The Joker"" in 1973?",4,Steve Miller Band,Willie Nelson,The Beatles,The Allman Brothers Band,1,1
,,,,,,1,Multiple Choice,Strains,Which of the following strains is an indica?,4,Strawberry Cough,Blueberry Kush,Super Lemon Haze,Jack Herer,2,1
,,,,,,1,Multiple Choice,Strains,The cannabis strain 24k Goldis often referred to as what?,4,Tangimal,Gold Leaf,Kosher Kush,Kosher Tangie,4,1
,,,,,,1,Multiple Choice,Legal Cannabis Worldwide,Recreational use of marijuana is legal in which of the following states?,4,Texas,Louisiana,Florida,Maine,4,1
,,,,,,1,Multiple Choice,Methods of Consumption,What is considered to be a cannabis sublingual?,4,Tincture,Brownie,Chocolate Bar,Macaroon,1,1
,,,,,,1,Multiple Choice,Methods of Consumption,"There are many cannabis products designed to provide pain relief without getting you ""high"".  Which of these products consistenty provides a steady stream of cannabis to the bloodstream discreetly?",4,Tincture,Transdermal Patch,Cannabis Lotion,Cannabis Salve,2,1
,,,,,,1,Multiple Choice,Methods of Consumption,Which method of consumption is best used for vaporizing cannabis flower?,3,Topicals,Ingestion,Inhalation,,3,1
,,,,,,1,True/False,Cannabis Culture,"In 1995, Ice Cube teamed up alongside Chris Tucker to bring us the cult classic film ""Friday"".",2,True,False,,,1,1
,,,,,,1,True/False,Cannabis Culture,High Times magazine was founded by Tom Forcade in 1976.,2,True,False,,,2,1
,,,,,,1,True/False,Cannabis Terms and Definitions,"In Hawaii, marijuana is called, ""Pakalolo"".",2,True,False,,,1,1
,,,,,,1,True/False,Facts and Myths,Large amounts of hemp seed or oil can act as a laxative and cause diarrhea.,2,True,False,,,1,1
,,,,,,1,True/False,Facts and Myths,Cannabis has not been reported to cause fatal overdose in humans.,2,True,False,,,1,1
,,,,,,1,True/False,Facts and Myths,Hemp seeds cannot be eaten raw.,2,True,False,,,2,1
,,,,,,1,True/False,Facts and Myths,Beer hops and marijuana belong to the same family of flowering plants.,2,True,False,,,1,1
,,,,,,1,True/False,Facts and Myths,Cameron Diaz bought weed from Snoop Dogg in high school.,2,True,False,,,1,1
,,,,,,1,True/False,Facts and Myths,Marijuana is a product of the Cannabis sativa plant.,2,True,False,,,1,1
,,,,,,1,True/False,Facts and Myths,The first thing ever sold online was a bong.,2,True,False,,,2,1
,,,,,,1,True/False,Facts and Myths,The amount of THC in marijuana has been increasing steadily over the past few decades.,2,True,False,,,1,1
,,,,,,1,True/False,Facts and Myths,Using marijuana can lead to the use of harder drugs such as heroin or cocaine.,2,True,False,,,2,1
,,,,,,1,True/False,Facts and Myths,Marijuana is derived from the Hemp plant.,2,True,False,,,2,1
,,,,,,1,True/False,Facts and Myths,"Cannabis, hemp, and marijuana are all the same.",2,True,False,,,2,1
,,,,,,1,True/False,History,Former U.S. President James Monroe openly smoked hashish when he served as ambassador to France,2,True,False,,,1,1
,,,,,,1,True/False,History,The first American flag was made from industrial hemp.,2,True,False,,,1,1
,,,,,,1,True/False,History,The FBI was created by US President Nixon to help enforce the Controlled Substancees Act.,2,True,False,,,2,1
,,,,,,1,True/False,Legal Cannabis Worldwide,"There are more marijuana dispensaries in Denver, CO than Starbucks.",2,True,False,,,1,1
,,,,,,1,True/False,Legal Cannabis Worldwide,"In 2018, Paraguay legalized marijuana for recreational used.",2,True,False,,,2,1
,,,,,,1,True/False,Legal Cannabis Worldwide,"Any person, 18 years or older with a government-issued photo ID can legally enter a recreational cannabis dispensary.",2,True,False,,,2,1
,,,,,,1,True/False,Legal Cannabis Worldwide,It is legal to consume cannabis in a public place in recreationally legal states.,2,True,False,,,2,1
,,,,,,1,True/False,Legal Cannabis Worldwide,It is illegal to possess or use cannabis on federal land.,2,True,False,,,1,1
,,,,,,1,True/False,Legal Cannabis Worldwide,Recreational marijuana use is legal in Canada.,2,True,False,,,1,1
,,,,,,1,True/False,Legal Cannabis Worldwide,"Canada has legalized cannabis country-wide, however each province and territory has its own set of rules and regulations.",2,True,False,,,1,1
,,,,,,1,True/False,Legal Cannabis Worldwide,The California Decriminalization Bill of 1973 abolished criminal penalties for possession of small amounts of marijuana.,2,True,False,,,2,1
,,,,,,1,True/False,Legal Cannabis Worldwide,You can enter a recreational cannabis dispensary with a damaged or destroyed state ID.,2,True,False,,,2,1
,,,,,,1,True/False,Legal Cannabis Worldwide,Medicinal use of marijuana is permitted in the state of Wyoming.,2,True,False,,,2,1
,,,,,,1,True/False,Legal Cannabis Worldwide,Medicinal use of marijuana is permitted in the state of Texas.,2,True,False,,,2,1
,,,,,,1,True/False,Legal Cannabis Worldwide,Medicinal use of marijuana is permitted in the state of Florida.,2,True,False,,,1,1
,,,,,,1,True/False,Legal Cannabis Worldwide,Medicinal use of marijuana is permitted in the state of Mississippi.,2,True,False,,,2,1
,,,,,,1,True/False,Legal Cannabis Worldwide,Medicinal use of marijuana is permitted in the state of Hawaii.,2,True,False,,,1,1
,,,,,,1,True/False,Legal Cannabis Worldwide,Medicinal use of marijuana is permitted in the state of Wisconsin.,2,True,False,,,2,1
,,,,,,1,True/False,Legal Cannabis Worldwide,Medicinal use of marijuana is permitted in the state of Iowa.,2,True,False,,,2,1
,,,,,,1,True/False,Legal Cannabis Worldwide,Medical use of marijuana is permitted in the state of Washington.,2,True,False,,,1,1
,,,,,,1,True/False,Legal Cannabis Worldwide,Medicinal use of marijuana is permitted in the state of California.,2,True,False,,,1,1
,,,,,,1,True/False,Legal Cannabis Worldwide,Medicinal use of marijuana is permitted in the state of Oregon.,2,True,False,,,1,1
,,,,,,1,True/False,Legal Cannabis Worldwide,Medicinal use of marijuana is permitted in the state of Alaska.,2,True,False,,,1,1
,,,,,,1,True/False,Legal Cannabis Worldwide,Medicinal use of marijuana is permitted in the state of Louisiana.,2,True,False,,,1,1
,,,,,,1,True/False,Legal Cannabis Worldwide,Medicinal use of marijuana is permitted in the state of Kansas.,2,True,False,,,2,1
,,,,,,1,True/False,Legal Cannabis Worldwide,In Quebec you can smoke cannabis anywhere tobacco is allowed.,2,True,False,,,1,1
,,,,,,1,True/False,Legal Cannabis Worldwide,You can legally transport cannabis between the United States and Canada.,2,True,False,,,2,1
,,,,,,1,True/False,Legal Cannabis Worldwide,"In the Canadian province of British Columbia, home cultivation is legal up to 4 plants.",2,True,False,,,1,1
,,,,,,1,True/False,Legal Cannabis Worldwide,"You must be at least 19 years of age or older to consume, purchase, and possess cannabis in the Canadian province of Manitoba.",2,True,False,,,1,1
,,,,,,1,True/False,Legal Cannabis Worldwide,It is LEGAL to grow cannabis in your home in the Canadian province of Manitoba.,2,True,False,,,2,1
,,,,,,1,True/False,Legal Cannabis Worldwide,"In the Canadian province of Nova Scotia, you must be at least 19 years of age to purchase, consume, possess, and grow cannabis.",2,True,False,,,1,1
,,,,,,1,True/False,Legal Cannabis Worldwide,A cannabis consumer must be at least 18 years of age or older to consume cannabis in the Canadian province of Quebec.,2,True,False,,,1,1
,,,,,,1,True/False,Methods of Consumption,Cannabis flower can be consumed through the process of dabbing on a quartz banger or e-nail.,2,True,False,,,2,1
,,,,,,1,True/False,Methods of Consumption,"With marijuana, concentrates are more potent than smoking.",2,True,False,,,1,1
,,,,,,1,True/False,Methods of Consumption,The bowl of a pipe or a bong is where your mouth goes.,2,True,False,,,2,1
,,,,,,1,True/False,Methods of Consumption,Blunts are cannabis rolled in paper,2,True,False,,,2,1
,,,,,,1,True/False,Methods of Consumption,Blunts are cannabis rolled in cigar paper made from tobacco plants and contain nicotine,2,True,False,,,1,1
,,,,,,1,True/False,Methods of Consumption,Topicals do not provide localized relief for consumers with muscle aches and soreness,2,True,False,,,2,1
,,,,,,1,True/False,Legal Cannabis Worldwide,The Green Panthers is a cannabis rights organization.,2,True,False,,,1,1
,,,,,,1,True/False,Legal Cannabis Worldwide,Alabama U.S. Senator Jeff Sessions smokes marijuana.,2,True,False,,,2,1
,,,,,,1,True/False,Science of Cannabis,"When ingesting cannabis edibles, your body needs to first digest and metabolize the edible product before you will feel any effects.",2,True,False,,,1,1
,,,,,,1,True/False,Science of Cannabis,Marijuana smoke contains carcinogenic combustion products.,2,True,False,,,1,1
,,,,,,1,True/False,Science of Cannabis,Chlorophyll is what makes marijuana purple.,2,True,False,,,2,1
,,,,,,1,True/False,Science of Cannabis,Marijuana is not addictive.,2,True,False,,,2,1
,,,,,,1,True/False,Science of Cannabis,The standard dose for a cannabis edible is considered to be 100mg.,2,True,False,,,2,1
,,,,,,1,True/False,Science of Cannabis,The effects of ingestions vs smoking can vary greatly depending on the patient.,2,True,False,,,1,1
,,,,,,1,True/False,Science of Cannabis,K2/Spice is a cannabis product that is composed of purified resin glands.,2,True,False,,,2,1
,,,,,,1,True/False,Science of Cannabis,"Using CBD alongside THC will not only enhance the benefits of both cannabinoids, it will also decrease the negative side effects of THC such as impairment or elevated heart rate.",2,True,False,,,1,1
,,,,,,1,True/False,Science of Cannabis,What is the name of cannabis that has less than 1% of THC?,2,True,False,,,1,1
,,,,,,1,True/False,Science of Cannabis,"About 24 hours after smoking marijuana, mental and physical abilities weakened.",2,True,False,,,1,1
,,,,,,1,True/False,Science of Cannabis,Marijuana is known to treat severe pain,2,True,False,,,1,1
,,,,,,1,True/False,Science of Cannabis,Marijuana is known to reduce nausea induced by cancer chemotherapy,2,True,False,,,1,1
,,,,,,1,True/False,Science of Cannabis,"Marijuana is known to alleviate symptoms of a wide range of medical conditions including cancer, HIV/AIDS, epilepsy, Alcheimer's Disease and multiple sclerosis",2,True,False,,,1,1
,,,,,,1,True/False,Science of Cannabis,Marijuana is known to help manage mental health conditions like PTSD,2,True,False,,,1,1
,,,,,,1,True/False,Science of Cannabis,"Sour Diesel is known for providing relief for stress, pain and depression.",2,True,False,,,1,1
,,,,,,1,True/False,Science of Cannabis,CBD gets you high.,2,True,False,,,2,1
,,,,,,1,True/False,Science of Cannabis,CBD improves your immune system.,2,True,False,,,1,1
,,,,,,1,True/False,Science of Cannabis,CBD does not treat disorders and diseases.,2,True,False,,,2,1
,,,,,,1,True/False,Science of Cannabis,CBD reduces inflammation.,2,True,False,,,1,1
,,,,,,1,True/False,Science of Cannabis,CBD does not reduce inflammation.,2,True,False,,,2,1
,,,,,,1,True/False,Science of Cannabis,Cannabis grow areas that are not ventilated well tend to develop insects like spidermites which will damage your crop.,2,True,False,,,1,1
,,,,,,1,True/False,Strains,"The cannabis strain 98 Aloha White Widow is known for its green nugs that are covered in trichomes, and for it's skunky, diesel aroma.",2,True,False,,,1,1
,,,,,,1,True/False,Strains,3rd Coast Panama Chunk is an indica dominant hybrid strain.,2,True,False,,,2,1
,,,,,,1,True/False,Strains,"707 Headband originated in Humboldt County, California. ",2,True,False,,,1,1
,,,,,,1,True/False,Strains,$100 OG Kush is a very stimulating sativa strain that has a pungent fruity aroma.,2,True,False,,,2,1
,,,,,,1,True/False,Strains,98 Aloha White Widow is classified as an indica strain.,2,True,False,,,2,1
,,,,,,1,True/False,Strains,24k Gold is classified as a sativa strain.,2,True,False,,,2,1
,,,,,,1,True/False,Strains,Blue Dream is a sativa-dominant hybrid.,2,True,False,,,1,1
,,,,,,1,True/False,Strains,Blue Dream is an indica-dominant hybrid.,2,True,False,,,2,1
,,,,,,1,True/False,Strains,Bubba Kush is an indica strain.,2,True,False,,,1,1
,,,,,,1,True/False,Strains,Bubba Kush is a sativa strain.,2,True,False,,,2,1
,,,,,,1,True/False,Strains,Green Crack is a sativa strain.,2,True,False,,,1,1
,,,,,,1,True/False,Strains,Pineapple Express is a sativa-dominant hybrid.,2,True,False,,,1,1
,,,,,,1,True/False,Strains, Pineapple Express is an indica-dominant hybrid.,2,True,False,,,2,1
,,,,,,1,True/False,Strains,Blue Cheese is an indica strain.,2,True,False,,,1,1
,,,,,,1,True/False,Strains,Jack Herer is a sativa strain.,2,True,False,,,1,1
,,,,,,1,True/False,Strains,Jack Herer is an indica strain.,2,True,False,,,2,1
,,,,,,1,True/False,Strains,Trainwreck is a sativa-dominant hybrid.,2,True,False,,,1,1
,,,,,,1,True/False,Strains,Trainwreck is an indica-dominant hybrid.,2,True,False,,,2,1
,,,,,,1,True/False,Strains,Super Lemon Haze is a sativa-dominant hybrid.,2,True,False,,,1,1
,,,,,,1,True/False,Strains,Lemon Haze is a sativa strain.,2,True,False,,,1,1
,,,,,,1,True/False,Strains,Lemon Haze is an indica strain.,2,True,False,,,2,1
,,,,,,1,True/False,Strains,Granddaddy Purple is an indica strain.,2,True,False,,,1,1
,,,,,,1,True/False,Strains,Granddaddy Purple is a sativa strain.,2,True,False,,,2,1
,,,,,,1,True/False,Strains,Purple Kush is a sativa strain.,2,True,False,,,2,1
,,,,,,1,True/False,Strains,Kosher Kush is a sativa strain.,2,True,False,,,2,1
,,,,,,1,Multiple Choice,Legal Cannabis Worldwide,"On October 17, 2018 the use of cannabis for recreational purposes became legal across what country?",4,Uraguay,Canada,United States,None of the Above,2,1
,,,,,,1,Multiple Choice,Methods of Consumption,What is the safest way to use marijuana?,4,Vaporizer,Eat it,Smoke it as a joint,In a bong with ice cold water,2,1
,,,,,,1,Multiple Choice,Legal Cannabis Worldwide,Which one of the following is NOT a marijuana company stock listed on NASDAQ?,4,Village Farms International,Intec Pharma Ltd.,Cronos Group Inc.,Pepperidge Farms Ltd.,4,1
,,,,,,1,Multiple Choice,Strains,Hybrid cannabis strain 13 Dawgs is a product of crossing G13 and which of the following strains?,4,White Widow,White Rhino,Gorilla Glue,None of the Above,4,1
,,,,,,1,Multiple Choice,Cannabis Culture,Which celebrity cannabis advocate released the cookbook ‘From Crook to Cook’ in October of 2018?,4,Wiz Khalifa,Snoop Dogg,Tommy Chong,Martha Stewart,2,1
,,,,,,1,Multiple Choice,Legal Cannabis Worldwide,Are religious uses of cannabis permitted in the United States?,3,Yes,No,"Yes, but only to Rastafarias",,2,1
,,,,,,1,Multiple Choice,Facts and Myths,What were the names of the vending machines in Seattle that dispensed marijuana flower buds in medical marijuana dispensaries? ,4,ZaZZZ,Green Machine,GaGGS,The Grinch,1,1
1,Are You A CannaWIZ?,Do you consider your brain the encyclopedia of cannabis?  Test your knowledge now!,1,,1,2,Multiple Choice,Facts and Myths,"According to a new Marist poll that was conducted in partnership with Yahoo, what percentage of U.S. adults have smoked marijuana?",4,12%,52%,32%,67%,2,
1,Are You A CannaWIZ?,Do you consider your brain the encyclopedia of cannabis?  Test your knowledge now!,1,,6,2,Multiple Choice,Methods of Consumption,"The rolling paper company Bambu is listed as one of the world's 1000 oldest companies, what did they produce before they started producing rolling papers?",4,Bible paper,Blunt wraps,Money,Notebooks,1,
1,Are You A CannaWIZ?,Do you consider your brain the encyclopedia of cannabis?  Test your knowledge now!,1,,2,2,Multiple Choice,Cannabis Culture,"With several movie and TV roles under his belt this actor/comedian not only has their own cannabis brand, but they also sit on the advisory board for the National Organization for the Reform of Marijuana Laws (NORML).",4,Cheech Marin,Seth Rogan,Tommy Chong,Joe Rogan,3,
1,Are You A CannaWIZ?,Do you consider your brain the encyclopedia of cannabis?  Test your knowledge now!,1,,5,2,Multiple Choice,Legal Cannabis Worldwide,"In 2012, what state legalized medical cannabis through the state legislature?",4,Nevada,Delaware,Connecticut,Idaho,3,
1,Are You A CannaWIZ?,Do you consider your brain the encyclopedia of cannabis?  Test your knowledge now!,1,,10,2,Multiple Choice,Strains,Which strain won the High Times Cannabis Cup in both 2008 and 2009?,2,Super Lemon Haze,Super Silver Haze,,,1,
1,Are You A CannaWIZ?,Do you consider your brain the encyclopedia of cannabis?  Test your knowledge now!,1,,7,2,True/False,Science of Cannabis,"The effects of cannabis that metabolizes through eating cannabis products are far stronger, and are felt a lot longer than inhaling cannabis smoke or vapor.",2,True,False,,,1,
1,Are You A CannaWIZ?,Do you consider your brain the encyclopedia of cannabis?  Test your knowledge now!,2,,8,2,Multiple Choice,Legal Cannabis Worldwide,"According to a November 2018 article by the Washington Post, the wholesale marijuana prices per pound have fallen by what percentage in Colorado since legalization in 2014? ",4,10%,30%,70%,50%,3,
1,Are You A CannaWIZ?,Do you consider your brain the encyclopedia of cannabis?  Test your knowledge now!,2,,10,2,Multiple Choice,Legal Cannabis Worldwide,What is the legal possesion limit in the state of California?,4,28.5 grams of marijuana flower and up to 8 grams of marijuana concentrate,2.5 ounces of marijuana flower and up to 8 grams of marijuana concentrate,1/8th an ounce of marijuana,1/8th an ounce of concentrated marijuana ,1,
1,Are You A CannaWIZ?,Do you consider your brain the encyclopedia of cannabis?  Test your knowledge now!,2,,1,2,Multiple Choice,Legal Cannabis Worldwide,"In 1973, what state became the first in the US to decriminalize cannabis, reducing the penalty for up to an ounce to a $100 fine?",4,Alaska,California,Oregon,Texas,3,
1,Are You A CannaWIZ?,Do you consider your brain the encyclopedia of cannabis?  Test your knowledge now!,2,,6,2,Multiple Choice,Cannabis Terms and Definitions,Cannabis has male and female parts; what is this called?,3,Meaning: (of a plant or invertebrate animal) having the male and female reproductive organs in separate individuals.,Dioecious,Origin is English and Greek to Modern Latin.,,2,
1,Are You A CannaWIZ?,Do you consider your brain the encyclopedia of cannabis?  Test your knowledge now!,2,,7,2,Multiple Choice,Cannabis Culture,"Who said, ""Some people are just better high""?",4,Miley Cyrus,Tim McGraw,Justin Timberlake,Taylor Swift,3,
1,Are You A CannaWIZ?,Do you consider your brain the encyclopedia of cannabis?  Test your knowledge now!,2,,9,2,Multiple Choice,Legal Cannabis Worldwide,What legal classification is marijuana?,4,Schedule I,Schedule II,Schedule III,Schedule IV,1,
1,Are You A CannaWIZ?,Do you consider your brain the encyclopedia of cannabis?  Test your knowledge now!,2,,2,2,True/False,Facts and Myths,Hemp requires minimal care and can grow in most climates.,2,True,False,,,1,1
1,Are You A CannaWIZ?,Do you consider your brain the encyclopedia of cannabis?  Test your knowledge now!,2,,5,2,True/False,History,"In 1958, future U.S. President Richard Nixon saw his friend Dean Martin in line for customs at Idlewild Airport in New York, he grabbed his bags and walked him through. However, there was 3 pounds of marijuana in his suitcase. Richard Nixon ""Muled"" 3 pounds of marijuana for Dean Martin.",2,True,False,,,2,1
1,Are You A CannaWIZ?,Do you consider your brain the encyclopedia of cannabis?  Test your knowledge now!,3,,6,2,Multiple Choice,Science of Cannabis,Which terpenoid contains anti-depressant and anti-inflammatory properties?,4,Linalool,Limonene,Pinene,Myrcene,4,1
1,Are You A CannaWIZ?,Do you consider your brain the encyclopedia of cannabis?  Test your knowledge now!,3,,7,2,Multiple Choice,Strains,"The parent genetics of 707 Headband Kush are Sour Diesel, OG Kush, and what other strain?",4,Master Kush,Bubba Kush,Granddaddy Purple,Mendocino Purps,1,1
1,Are You A CannaWIZ?,Do you consider your brain the encyclopedia of cannabis?  Test your knowledge now!,3,,4,2,True/False,Legal Cannabis Worldwide,"Cannabis is recreationally legal across Canada, however the rules and regulations can vary from province to province.",2,True,False,,,1,1
1,Are You A CannaWIZ?,Do you consider your brain the encyclopedia of cannabis?  Test your knowledge now!,3,,5,2,True/False,Science of Cannabis,The a-Pinene terpene produces a pine aroma.,2,True,False,,,1,1
1,Are You A CannaWIZ?,Do you consider your brain the encyclopedia of cannabis?  Test your knowledge now!,3,,10,2,Multiple Choice,History,"During the 1960's what U.S. university had the first experimental plot of marijuana grown on a designated site, using seeds from Mexico, Panama, Southeast Asia, Korea, India, Afghanistan, Iran, Pakistan and Lebanon? ",4,University of Florida,University of Oklahoma,University of Mississippi,Tulane University,3,1
1,Are You A CannaWIZ?,Do you consider your brain the encyclopedia of cannabis?  Test your knowledge now!,3,,1,2,Multiple Choice,Methods of Consumption,"This concentrate is created by blasting fresh frozen plant material, creating amazing terpene and cannabinoid profiles that resemble the scent and flavor of the live plant.",4,Wax,Budder,All of the Above,Live Resin,4,1
1,Are You A CannaWIZ?,Do you consider your brain the encyclopedia of cannabis?  Test your knowledge now!,4,,3,2,Multiple Choice,Cannabis Culture,Keith Stroup founded The National Organization for the Reform of Marijuana Laws (NORML) in what year?,4,1981,1972,1990,1970,4,1
1,Are You A CannaWIZ?,Do you consider your brain the encyclopedia of cannabis?  Test your knowledge now!,4,,7,2,Multiple Choice,Methods of Consumption,Which of these solvents are used during the extraction process to separate the resin gland that contain THC from the cannabis flower?,3,Alcohol,Hydrogen Peroxide,Amonia,,1,1
1,Are You A CannaWIZ?,Do you consider your brain the encyclopedia of cannabis?  Test your knowledge now!,4,,4,2,Multiple Choice,History,Cannabis is indigenous to what geographical area?,4,Central Asia,Pakistan,Japan,North America,1,1
1,Are You A CannaWIZ?,Do you consider your brain the encyclopedia of cannabis?  Test your knowledge now!,4,,2,2,Multiple Choice,Cannabis Culture,"A popular Sativa-dominant strain combined with a Haze Hybrid, Northern Light #5 and Shiva Skunk cross was named after which celebrity?",4,Obama Kush,Chuck Norris Black and Blue Dream,Snoop Dogg OG,Jack Herer,4,1
1,Are You A CannaWIZ?,Do you consider your brain the encyclopedia of cannabis?  Test your knowledge now!,4,,8,2,Multiple Choice,Legal Cannabis Worldwide,Which state declared cannabis a narcotic in 1931?,4,Oregon,Mississipi,Alaska,Texas,4,1
1,Are You A CannaWIZ?,Do you consider your brain the encyclopedia of cannabis?  Test your knowledge now!,4,,1,2,True/False,Science of Cannabis,The genetics of a strain one wants to grow can make a huge impact on how the plant grows.,2,True,False,,,1,1
1,Are You A CannaWIZ?,Do you consider your brain the encyclopedia of cannabis?  Test your knowledge now!,4,,9,2,True/False,Legal Cannabis Worldwide,Utah and Vermont banned marijuana in 1915.,2,True,False,,,1,1
1,Are You A CannaWIZ?,Do you consider your brain the encyclopedia of cannabis?  Test your knowledge now!,4,,10,2,True/False,Science of Cannabis,CBN is a breakdown product of THC.,2,True,False,,,1,1
1,Are You A CannaWIZ?,Do you consider your brain the encyclopedia of cannabis?  Test your knowledge now!,5,,8,2,True/False,Legal Cannabis Worldwide,"Government entities use RFID technology combined with serialized item tracking, so they can track the entire ""inventory"" from seed-to-sale acros the state.",2,True,False,,,1,1
1,Are You A CannaWIZ?,Do you consider your brain the encyclopedia of cannabis?  Test your knowledge now!,5,,7,2,True/False,Legal Cannabis Worldwide,"You must be at least 18 years of age or older to consume, purchase, possess, or grow cannabis in Alberta, Canada.",2,True,False,,,1,1
1,Are You A CannaWIZ?,Do you consider your brain the encyclopedia of cannabis?  Test your knowledge now!,5,,4,2,True/False,Science of Cannabis,CBD is the non-intoxicating compound found in the cannabis plant.,2,True,False,,,1,1
1,Are You A CannaWIZ?,Do you consider your brain the encyclopedia of cannabis?  Test your knowledge now!,5,,6,2,True/False,Strains,"There are over 6,000 recognized strains of marijuana.",2,True,False,,,1,1
1,Are You A CannaWIZ?,Do you consider your brain the encyclopedia of cannabis?  Test your knowledge now!,5,,3,2,True/False,Legal Cannabis Worldwide,The Cannabis Control and Licensing Act (CCLA) allows cannabis smoking and vaping everywhere tobacco smoking and vaping is prohibited.,2,True ,False,,,2,1
1,Are You A CannaWIZ?,Do you consider your brain the encyclopedia of cannabis?  Test your knowledge now!,5,,5,2,Multiple Choice,Strains,Which celebrity shares their name with a cannabis strain?,4,Whoopi Goldberg,Blue Ivy Carter,The Game,Montel Williams,2,1
2,420 Know It All,Flex your cannabis knowledge now!,1,,10,2,Multiple Choice,Legal Cannabis Worldwide,"In the state of Nevada, the legal purchase amount for Medical Marijuana Patient is:",3,"1 ounce of marijuana or up to 1/8th of an ounce of concentrated marijuana not to exceed 1,750 mg of THC",2.5 ounces of usable marijuana,1/8th of an ounce of marijuana,,1,1
2,420 Know It All,Flex your cannabis knowledge now!,1,,3,2,Multiple Choice,Facts and Myths,The Hollywood sign has been changed to 'Hollyweed' twice by local artists. In what year did this first happen?,4,1976,1999,2006,2017,1,1
2,420 Know It All,Flex your cannabis knowledge now!,1,,9,2,Multiple Choice,Legal Cannabis Worldwide,In what year did Illinois decriminlize cannabis through the state legsilature?,4,2015,2010,2016,2001,3,1
2,420 Know It All,Flex your cannabis knowledge now!,1,,7,2,Multiple Choice,Science of Cannabis,Genetics impact how a strain grows including which of the following?,4,All of the Above,How tall or short the plant tends to grow.,How quickly the plant grows.,How big the buds grow.,1,1
2,420 Know It All,Flex your cannabis knowledge now!,1,,1,2,Multiple Choice,Cannabis Culture,What country music star sits on the advisory board for the National Organization for the Reform of Marijuana Laws (NORML)?,4,Darius Rucker,Kelly Clarkson,Carrie Underwood,Willie Nelson,4,1
2,420 Know It All,Flex your cannabis knowledge now!,1,,8,2,Multiple Choice,History,"In October of 1937, Samuel Caldwell was the first U.S. citizen arrested under the Marijuana Tax Act for selling marijuana without paying the newly mandated tax. What was his punishment?",4,Life in prison,"$20,000 fine","Fined $1,000 and sentenced to four years of hard labor in Leavenworth",Death,3,1
2,420 Know It All,Flex your cannabis knowledge now!,1,,2,2,Multiple Choice,Cannabis Terms and Definitions,The most psychoactive cannabinoid within the cannabis plant is ________?,4,Tetrahydrocannabinol (THC),Cannabidiol (CBD),Tetrahydrocannabivarinic Acid (THCVA),Cannabinol (CBN),1,1
2,420 Know It All,Flex your cannabis knowledge now!,1,,6,2,True/False,Facts and Myths," Due to legalization, the number of young people who believe regular marijuana use is risky is decreasing.",2,True,False,,,1,1
2,420 Know It All,Flex your cannabis knowledge now!,2,,10,2,Multiple Choice,Legal Cannabis Worldwide,Maine legalized medical cannabis through a ballot measure in what year?,4,1998,1996,1994,1999,4,1
2,420 Know It All,Flex your cannabis knowledge now!,2,,9,2,Multiple Choice,Cannabis Culture,Which of the following annual Vancouver cannabis events does cannabis activist Dana Larsen organize?,4,4/20 Celebration at Sunset Beach,Cannabis Day,Global Marijuana March,All of the Above,4,1
2,420 Know It All,Flex your cannabis knowledge now!,2,,7,2,Multiple Choice,Cannabis Culture,What famous comedian said: “Why is marijuana against the law? It grows naturally upon our planet. Doesn’t the idea of making nature against the law seem to you a bit...unnatural?” ,4,Bill Hicks,Rodney Dangerfield,Chris Rock,Mitch Hedberg,1,1
2,420 Know It All,Flex your cannabis knowledge now!,2,,6,2,Multiple Choice,Science of Cannabis,"What cannabinoid is useful as an antidepressant, a muscle relaxant, an antibiotic and antifungal agent, as well as a great blood pressure reducer?",4,CBC,THCV,THC,None of the above,4,1
2,420 Know It All,Flex your cannabis knowledge now!,2,,4,2,Multiple Choice,Methods of Consumption,Which statement is true for oral ingestion.,2,Oral ingestion offers consumers a method of consumption that does not require the use of lungs,Oral Ingestion offers consumers a method of consumption that requires the use of lungs,,,1,1
2,420 Know It All,Flex your cannabis knowledge now!,2,,6,2,Multiple Choice,Science of Cannabis,Cannabis seeds that flower after the plant has reached a certain phase of development are called what?,4,Sativa,Autoflowering seeds,Photoperiod flowering plants,Standard Seeds,2,1
2,420 Know It All,Flex your cannabis knowledge now!,2,,3,2,True/False,Legal Cannabis Worldwide,A medical consumer's confidential information may be released at any time to a third party without the consumer or caregiver's expressed written consent.,2,True,False,,,2,1
2,420 Know It All,Flex your cannabis knowledge now!,2,,10,2,True/False,Legal Cannabis Worldwide,"In Canada, it is legal to fly with cannabis as long as you remain within Canada and abide by possession limits of the departure and arrival province.",2,True,False,,,1,1
2,420 Know It All,Flex your cannabis knowledge now!,2,,5,2,True/False,Science of Cannabis,"The terpene a-Pinene is known to aid in the treatment of asthma, pain, inflammation, ulcers, anxiety, and cancer.",2,True,False,,,1,1
2,420 Know It All,Flex your cannabis knowledge now!,2,,2,2,True/False,Science of Cannabis,Phosphorus is NOT an important element to the growth of cannabis.,2,True,False,,,2,1
2,420 Know It All,Flex your cannabis knowledge now!,2,,7,2,True/False,Strains,13 Dawgs is a classic sativa strain that induces creativity and focus.,2,True,False,,,2,1
2,420 Know It All,Flex your cannabis knowledge now!,2,,8,2,Multiple Choice,Cannabis Culture,The Hash Bash began in 1972 and is held every year on the first Saturday in April at noon in what U.S. university?,4,University of Oregon,University of Colorado Boulder,"University of California, Berkeley",University of Michigan,4,1
2,420 Know It All,Flex your cannabis knowledge now!,3,,2,2,Multiple Choice,Legal Cannabis Worldwide,"How old must a cannabis consumer be to purchase recreational cannabis in British Columbia, Canada?",4,19,18,20,21,1,1
2,420 Know It All,Flex your cannabis knowledge now!,3,,6,2,Multiple Choice,Legal Cannabis Worldwide,What state legalized medical cannabis through a ballot measure in 2010?,4,Arizona,New Mexico,New Jersey,Delaware,1,1
2,420 Know It All,Flex your cannabis knowledge now!,3,,5,2,Multiple Choice,History,Which of these items was made from hemp?,4,The First American flag made by Betsy Ross,Superman's Cape for the Movies,A Sickle Blade,All of the Above,1,1
2,420 Know It All,Flex your cannabis knowledge now!,3,,10,2,True/False,History,The DEA is a US agency within the Department of Justice to enforce the Controlled Substances Act.,2,True,False,,,1,1
2,420 Know It All,Flex your cannabis knowledge now!,3,,7,2,True/False,Legal Cannabis Worldwide,"A customer's medical condition, purchase history and consumption habits are not considered confidential information.",2,True,False,,,2,1
2,420 Know It All,Flex your cannabis knowledge now!,3,,1,2,True/False,Methods of Consumption,The oldest concentrate known to man is BHO.,2,True,False,,,2,1
2,420 Know It All,Flex your cannabis knowledge now!,3,,1,2,True/False,Legal Cannabis Worldwide,"Canadian cannabis advocates Brian Taylor and Marc Emery, created the British Columbia Marijuana Party in 2001.",2,True,False,,,1,1
2,420 Know It All,Flex your cannabis knowledge now!,4,,2,2,Multiple Choice,Legal Cannabis Worldwide,"Of the 8.2 million marijuana arrests between 2001 and 2010, what percentage were for simply having marijuana.",4,88%,12%,43%,67%,1,1
2,420 Know It All,Flex your cannabis knowledge now!,4,,7,2,Multiple Choice,Cannabis Culture,"Which famous US politician was quoted saying, ""If someobdy's gonna smoke a joint...And not do anybody else any harm...Then perhaps there are other things that our cops should be looking at.""",4,Hillary Clinton,Bernie Sanders,Sarah Palin,Ted Cruz,3,1
2,420 Know It All,Flex your cannabis knowledge now!,4,,3,2,Multiple Choice,Methods of Consumption,It is best to recommend _______ as an appropriate method of consumption to someone who wants to avoid smoking cannabis.,3,Ingestion,Topical,Inhalation,,3,1
2,420 Know It All,Flex your cannabis knowledge now!,4,,10,2,Multiple Choice,Legal Cannabis Worldwide,"In 2019, which state decriminlized cannabis through the state legislature?",4,New Mexico,Arizona,Utah,MIssouri,1,1
2,420 Know It All,Flex your cannabis knowledge now!,4,,8,2,True/False,Cannabis Terms and Definitions,"""420"" is celebrated on April 20th for smoking marijuana. ""720"" is celebrated on July 10th and celebrated the dabs and cannabis concentrates on this day. ",2,True,False,,,1,1
2,420 Know It All,Flex your cannabis knowledge now!,4,,1,2,True/False,History,U.S. President Harry Truman signed the Marijuana Tax Act of 1937 that placed the first tax on the sale of cannabis.  ,2,True,False,,,2,1
2,420 Know It All,Flex your cannabis knowledge now!,4,,4,2,True/False,Science of Cannabis,"Some of the potential effects of the a-Pinene terpene include alertness, memory retention, and it can also counteract some of the effects of THC.",2,True,False,,,1,1
2,420 Know It All,Flex your cannabis knowledge now!,4,,5,2,True/False,Strains,"501st OG is a hybrid strain that is typicall 70% indica, 30% sativa.",2,True,False,,,1,1
2,420 Know It All,Flex your cannabis knowledge now!,5,,2,2,Multiple Choice,Legal Cannabis Worldwide,In what year did Montana legalize medical cannabis through a ballot measure?,4,2002,1995,2009,2004,4,1
2,420 Know It All,Flex your cannabis knowledge now!,5,,5,2,Multiple Choice,Methods of Consumption,"What process of extraction uses water, temperature, and pressure to extract the resin glands containing THC from the cannabis flower?",2,Non-Solvent Extraction,Solvent Extraction,,,1,1
2,420 Know It All,Flex your cannabis knowledge now!,5,,4,2,True/False,Cannabis Culture,"Dana Larsen is one of the most well known Canadian cannabis advocates.  He served for 10 years as editor of Cannabis Culture Magazine, and was the co-founder of the Vancouver Seed Bank.",2,True,False,,,1,1
2,420 Know It All,Flex your cannabis knowledge now!,5,,3,2,True/False,Facts and Myths,A study from New Zealand conducted in part by researchers at Duke University showed that people who started smoking marijuana heavily in their teens and had an ongoing marijuana use disorder lost an average of 8 IQ points between ages 13 and 38.,2,True,False,,,1,1
2,420 Know It All,Flex your cannabis knowledge now!,5,,10,2,True/False,Science of Cannabis,"Gastrointestinal absorption will be typically felt 3-4 hours after consumption, and the effects last for 24 hours.",2,True,False,,,2,1
2,420 Know It All,Flex your cannabis knowledge now!,5,,6,2,True/False,Science of Cannabis,"When entering the body, THC stimulates cannabinoid receptors in the brain.",2,True,False,,,1,1
2,420 Know It All,Flex your cannabis knowledge now!,5,,7,2,True/False,Science of Cannabis,The a-Pinene terpene produces a spicy aroma.,2,True,False,,,2,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,Blacks are how many times more likely than whites to be arrested for marijuana.,4,1.73,5.73,3.73,10.73,3,1
,,,,,,2,Multiple Choice,Cannabis Culture,"In what year was ""High Times"" magazine founded by Tom Forçade?",4,1974,1954,1964,1984,1,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,Connecticut decriminalized cannabis through the state legislature in what year?,4,2010,2012,2004,2011,4,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,"Colorado and Washington became the first states in the US to legalize the recreational use of cannabis, what year did this happen?",4,2013,2010,2012,2006,3,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,In what year was a ballot measure approved to legalize the medical use of cannabis in North Dakota?,4,2016,2015,1999,2005,1,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,In what year did Oklahoma legalize medical cannabis through a ballot measure?,4,2018,2017,2015,2005,1,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,In what year did New Mexico decriminalize cannabis through the state legsilature?,4,2019,2016,2018,2010,1,1
,,,,,,2,Multiple Choice,Cannabis Culture,"The lyric ""Hey-ay-ay-ay/Smoke weed every day"" comes from which of the following songs?",4,"""The Next Episode""","""2001""","""Gin and Juice""","""Smoke Some Weed""",1,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,"In the state of Nevada, the legal purchase amount for Medical Marijuana Patients is:",3,1/8th of an ounce of Marijuana,2.5 ounces of useable Marijuana,"1 ounce of marijuana or up to 1/8th of an ounce of concentrated marijuana not to exceed 1,750 mg of THC",,3,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,In what year did Utah and Vermont ban marijuana?,4,1914,1923,1927,None of the Above,4,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,"In what year was cannabis restricted in El Paso, TX?",4,1915,1914,1913,1912,1,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,"In what year did California, Maine, Wyoming, and Indiana ban marijuana?",4,1917,1915,1913,1911,3,1
,,,,,,2,Multiple Choice,History,DMHP is a synthetic version of marijuana. When was it developed by the U.S. military?,4,1959,1949,1969,1979,2,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,"Texas law was amended in what year, to declare possession of four ounces or less a misdemeanor?",4,1972,1999,1989,1973,4,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,In what year was a ballot measure approved to leaglize recreational cannabis in Maine?,4,1994,2015,2012,2016,4,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,In what year was a ballot measure approved to leaglize recreational cannabis in Massachusetts?,4,1999,2017,2016,2012,3,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,In what year was a ballot measure approved to legalize the medical use of cannabis in Florida?,4,1999,2002,2015,2016,4,1
,,,,,,2,Multiple Choice,Science of Cannabis,How many weeks does a cannabis plant typically stay in the seedling phase?,4,2-6 weeks,2-3 weeks,None of the above,4-5 weeks,3,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,"In the state of Nevada, the legal possession amount for Medical Marijuana Patients is:",3,2.5 ounces of useable marijuana,1/8th of an ounce of marijuana,"1 ounce of marijuana or up to 1/8th of an ounce of concentrated marijuana not to exceed 1,750 mg of THC",,1,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,"In the state of Nevada, the legal possession amount for Medical Marijuana Patients is:",3,2.5 ounces of useable Marijuana,1/8th of an ounce of Marijuana,"1 ounce of Marijuana or up to 1/8th of an ounce of concentrated marijuana not to exceed 1,750 mg of THC",,1,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,Hawaii became the first state in the US to legalize medical cannabis through the state legislature in what year?,4,2000,2001,1995,1996,1,1
,,,,,,2,Multiple Choice,Cannabis Culture,Steph Sherer founded Americans for Safe Access in what year?,4,2001,2002,1999,1971,2,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,Arizona legalized medical cannabis through a ballot measure in what year?,4,2001,2002,2010,2014,3,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,Michigan approved a ballot measure to legalize medical cannabis in what year?,4,2001,2008,2003,1992,2,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,New Jersey legalized medical cannais through the state legislature in what year?,4,2001,2010,2011,2005,2,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,Alaska legalized the use of recreational cannabis through a ballot measure in what year?,4,2001,2014,2012,2010,2,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,In what year was a ballot measure approved to leaglize recreational cannabis in Nevada?,4,2002,2005,2016,2004,3,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,Oregon legalized the use of recreational cannabis through a ballot measure in what year?,4,2002,2017,2010,2014,4,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,In what year did Nevada decriminalize cannabis through the state legislature?,4,2002,2000,2001,1996,3,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,In what year was a ballot measure approved to leaglize recreational cannabis in California?,4,2002,2016,1996,2005,2,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,In what year was a ballot measure approved to legalize the medical use of cannabis in Arkansas?,4,2002,2016,2015,2011,2,1
,,,,,,2,Multiple Choice,Strains,The strain Amnesia Haze won the High Times Cannabis Cup in what year?,4,2003,2004,2005,2006,2,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,In what year did Vermont legalize medical cannabis through the state legislature?,4,2005,2006,2004,2007,3,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,Rhode Island legalized medical cannabis through the state legislature in what year?,4,2005,1996,2006,2001,3,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,In what year did New Mexico legalize medical cannabis through the state legislature?,4,2005,2002,2001,2007,4,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,Massachusetts approved a ballot measure to decriminalize cannabis in what year?,4,2009,2008,2004,2001,2,1
,,,,,,2,Multiple Choice,Cannabis Culture,Jane West and Jazmin Hupp founded Women Grow in what year?,4,2010,1999,2014,2003,3,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,California state legislators reduced penalties for cannabis to a civil infraction in what year?,4,2010,2011,2002,2017,1,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,Connecticut decriminalized cannabis through the state legislature in what year?,4,2010,2011,2012,2004,2,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,Delaware legalized medical cannabis through the state legislature in what year?,4,2010,2017,2011,2000,3,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,Minnesota and New York legalized medical cannabis through their state legislatures in what year?,4,2010,2011,2014,2012,3,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,Connecticut legalized medical cannabis through the state legislature in what year?,4,2011,2002,2015,2012,4,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,Connecticut legalized medical cannabis through the state legislature in what year?,4,2011,2012,2002,2015,2,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,Delaware legalized medical cannabis through the state legislature in what year?,4,2011,2010,2017,2000,1,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,Washington Initiative 502 (I-502) was an initiative to the Washington State Legislature that was passed in what year?,4,2011,2010,2012,2005,3,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,Washington Initiative 502 (I-502) was an initiative to the Washington State Legislature that was passed in what year?,4,2012,2011,2010,2005,1,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,New Hampshire legalied medical cannabis through the state legislature in what year?,4,2012,2013,2005,2016,2,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,Vermont decriminalized cannabis in what year?,4,2012,2013,2014,2016,2,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,Vermont decriminalized cannabis in what year?,4,2012,2014,2016,2013,4,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,New Hampshire legalied medical cannabis through the state legislature in what year?,4,2012,2005,2013,2016,3,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,In what year did Delaware decriminalize cannabis through the state legislature?,4,2012,2015,2005,2011,2,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,In what year did Louisiana legsilators pass a limited medical cannabis law?,4,2012,2011,2015,2013,3,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,"Colorado and Washington became the first states in the US to legalize the recreational use of cannabis, what year did this happen?",4,2013,2010,2012,2006,3,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,In what year did Illinois legalize medical cannabis through the state legislature?,4,2014,2012,2013,2010,3,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,In what year did Illinois legalize medical cannabis through the state legislature?,4,2014,2013,2012,2010,2,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,Minnesota legalized medical cannabis through the state legislature in what year?,4,2015,2010,2012,2014,4,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,New York state legalized medical cannabis through the state legislature in what year?,4,2015,2010,2012,2014,4,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide, In what year did Ohio legalize the medical use of cannabis through the state legislature?,4,2015,2016,2011,2010,2,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,In what year did Pennsylvania legalize medical cannabis through the state legislature?,4,2015,2011,2016,2010,3,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,Missouri decriminalized cannabis through the state legislature in what year?,4,2015,2014,2010,2012,2,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,West Virginia legalized the use of medical cannabis through the state legislature in what year?,4,2015,2010,2017,2011,3,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,In what year did Michigan approve a ballot measure to legalize the recreational use of cannabis?,4,2017,2018,2009,2010,2,1
,,,,,,2,Multiple Choice,Science of Cannabis,How long does it take the average person to pass a marijuana hair test if the sample is about 1.5 inches long? ,4,6 months,3 months,1 month,9 months,2,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,"In the state of Nevada, patient records should be maintained for at least...",4,6 months to 1 year,5 years,3 years,10 years,2,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,"In the state of Nevada, patient records should be maintained for at least:",4,6 months to 1 year,3 years,5 years,10 years,3,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,"Home cultivation is legal in the Canadian province of Alberta, how many plants can a consumer legally grow?",4,8,2,4,1,3,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,"In the state of Nevada, all dispensary employees are required to have:",3,A medical marijuana recommendation,A medical marijuana certification,An agent card,,3,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,"In the state of Nevada, all dispensary employees are required to have:",3,A Medical Marijuana Recommendation,An Agent Card,A Medical Marijuana Certification,,2,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,"In 2014, what two states legalized the use of recreational cannabis through a ballot measure?",4,Alaska and Oregon,Oregon and Washington,Nevada and California,Arizona and Alaska,1,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,"In 1975, which 5 states decriminalized cannabis?",4,"Alaska, Maine, Colorado, California, and Ohio","Nevada, California, Ohio, Alaska, and Main","Oregon, California, Ohio, Minnesota, and Nevada","Alaska, Nebraska, New York, Washington, and Oregon",1,1
,,,,,,2,Multiple Choice,Cannabis Culture,What year did Cannabis Culture Magazine cease it's printed publication to devote its resources to its online publication?,4,All of the above,2000,2009,2010,3,1
,,,,,,2,Multiple Choice,Cannabis Culture,Whose birthday is on 4/20?,4,All of the Above,Adolf Hitler,Jessica Lange,Carmen Electra,1,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,Colorado's measure outlining a statewide drug policy for cannabis to amend the Colorado State Constitution was labeled what?,4,Amendment 64,Initiative 502,Amendment 420,Act 710,1,1
,,,,,,2,Multiple Choice,Cannabis Culture,"Keith Stroup founded NORML (The National Organization for the Reform of Marijuana Laws) in 1970 using $5,000 in seed money from which foundation?",4,American Cancer Society,Ford Foundation,Playboy Foundation,The Reinberger Foundation,3,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,"Aurora Sky boasts an 800,000-square-foot greenhouse on 30 acres of land in what country?",4,Amsterdam,United States,Canada,United Kingdom,3,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,What state legalized medical cannabis through the state legislature in 2007?,4,Arizona,Idaho,New Mexico,Mississippi,3,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,"In 2003, what bill was introduced in California to regulate medical marijuana use in reference to 420 in marijuana culture?",4,Bill 420,California Senate Bill 420,California Proposition 215,California Proposition 19,2,1
,,,,,,2,Multiple Choice,Cannabis Culture,"This cannabis advocate was the lead organizer and fundraiser for I-59, Washington D.C.'s medical cannabis initiative.",4,Bill Maher,Jack Herer,Steve DeAngelo,Nancy Pelosi,3,1
,,,,,,2,Multiple Choice,Strains,Which strain is a cross of Mazar x Blueberry and Cherry Pie?,3,Blood Orange Kush,Bloodhound,Bloodwalker,,3,1
,,,,,,2,Multiple Choice,Strains,Which celebrity does not share their name with a cannabis strain?,4,Blue Ivy Carter,Marshawn Lynch,Barack Obama,Martha Stewart,4,1
,,,,,,2,Multiple Choice,Strains,Which of the following strains is an indica?,3,Blue Ox,Blue Rhino,Blue Sherbert,,1,1
,,,,,,2,Multiple Choice,Cannabis Culture,"Songs about Cannabis aren't just limited to rock and roll or hip hop, this country star released the song ""Smoke a LIttle Smoke"" in 2009.",4,Brad Paisley,Eric Church,Dierks Bentley,Clay Aiken,2,1
,,,,,,2,Multiple Choice,Strains,501st OG is the product of Rare Dankness 1 and what strain?,4,Bubba Kush,XXX OG,Skywalker OG,541 Kush,3,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,What US state was the first to license on-site marijuana consumption at cannabis stores?,4,California,Alaska,Washington,Nevada,2,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,Initiative 502 (I-502) was an initiative to legalize small amounts of marijuana-related products for adults 21 years or older for individuals in what state?,4,California,Colorado,Washington,Nebraska,3,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,Which two states were first to legalize cannabis for recreational use?,4,California and Oregon,Washington and Oregon,California and Colorado,None of the Above,4,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,Ballot measures were approved in what states to legalize recreational cannabis in 2016?,4,"California, Indiana, Ohio, and Pennsylvania","Nevada, Maine, Kentucky, and Arizona","Arizona, California, Massachusetts, and Maine","California, Nevada, Maine, and Massachusetts",4,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,Ballot measures were approved in what states to legalize medical cannabis in 2016?,4,"California, Nevada, and Maine","Florida, California, and Nevada","Arkansas, Florida, and North Dakota","Arkansas, Mississippi, and Delaware",3,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,What country was the first in the modern era to legalize cannabis as of December 2013?,4,Canada,South Africa,Uruguay,None of the Above,3,1
,,,,,,2,Multiple Choice,Science of Cannabis,_______ _______ are located throughout the body and are part of the endocannabinoid system.,4,Cannabis receptors,Endocannabinoid receptors,Cannabinoid receptors,,3,1
,,,,,,2,Multiple Choice,Science of Cannabis,What are the two types of cannabinoids receptors in our bodies called?,4,CB1 and CB2,RB2 and RB3,ECS1 and ECS2,CBD1 and CBD2,1,1
,,,,,,2,Multiple Choice,Methods of Consumption,THC is metabolized from delta-9 THC into what chemical after it passes through the liver?,4,CBD,11-hydroxy THC,delta-8 hydroxy,THCA,2,1
,,,,,,2,Multiple Choice,Science of Cannabis,Which of these cannabinoids are known to be a neuroprotectant?,4,CBD,THC,CBDA,THCVA,2,1
,,,,,,2,Multiple Choice,Cannabis Culture,"What 1998 movie starring Vince Vaughn, and Joaquin Phoenix is about a man sentenced to death for buying hash is Malaysia?",4,Clay Pigeons,Midnight Express,Leaves of Grass,Return to Paradise,4,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,Amendment 64 was a measure outlining a statewide drug policy for cannabis to amend the Constitution of what state?,4,Colorado,Washington,California,Nebraska,1,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,"In 2012, two states became the first in the United States to legalize the recreational use of cannabis, what states were they?",4,Colorado and Nevada,California and Washington,New York and Florida,Colorado and Washington,4,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,"In 2012, two states became the first in the United States to legalize the recreational use of cannabis, what states were they?",4,Colorado and Washington,Colorado and Nevada,California and Washington,New York and Florida,1,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,"In 2011, what state legalized medical cannabis through state legislature?",4,Connecticut,Delaware,Rhode Island,Utah,2,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,"In 2011, what state decriminalized cannabis through the state legislature?",4,Connecticut,Delaware,New York,"Washington, D.C.",1,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,What state decriminilized cannabis through the state legislature in 2015?,4,Delaware,Alaska,Oregon,Utah,1,1
,,,,,,2,Multiple Choice,Strains,Cannabis strain 13 Dawgs is a hybrid strain created by crossing which two strains genetics?,4,G13 and Chemdawg,OG Kush and Chemdawg,G13 and Granddaddy Purple,Cherry Pie and Girl Scout Cookies,1,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,"The legal sale of cannabis started on July 19, 2017 in what country?",4,Germany,Canada,Uruguay,The United States,3,1
,,,,,,2,Multiple Choice,Strains,Which strain was developed to help treat seizures without the risk of getting stoned?,4,Girl Scout Cookies,Bruce Banner,Kosher Kush,Charolette's Web,4,1
,,,,,,2,Multiple Choice,Science of Cannabis,Which of the following is a small family of flowering plants that includes 170 different species including Cannabis?,4,Hemp,Indica,Cannabaceae,None of the Above,3,1
,,,,,,2,Multiple Choice,Science of Cannabis,"There are several different mediums for growing cannabis, which of the following describes growing cannabis without soil?",3,Hyrdoponic,Outdoor,Greenhouse,,1,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,"In 2013, two states legalized medical cannabis through the state legislature, what states were they?",4,Illinois and New Hampshire,Indiana and New York,New Hampshire and Nevada,Alaska and Illinois,1,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,What state decriminlized cannabis through the state legsialture in 2016?,4,Indiana,Pennsylvania,Ohio,Illinois,4,1
,,,,,,2,Multiple Choice,Science of Cannabis,The strain 501st OG has been widely used and recommended for the treatment of what?,4,Inflammation,Fatigue,Chronic Stress,None of the Above,3,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,Colorado's measure outlining a statewide drug policy for cannabis to amend the Colorado State Constitution was labeled what?,4,Initiative 502,Amendment 420,Amendment 64,Act 710,3,1
,,,,,,2,Multiple Choice,Cannabis Culture,The National Organization for the Reform of Marijuana Laws (NORML) was founded in 1970 by who?,4,Keith Stroup,Tommy Chong,Nancy Botwin,Alice O'Leary,1,1
,,,,,,2,Multiple Choice,Strains,"What sativa-dominant hybrid shares the genetics from the strains Headband, Sour Diesel, and OG Kush?",4,Khalifa Kush,Granddaddy Purp,3 Kings,Harmony,3,1
,,,,,,2,Multiple Choice,Science of Cannabis,"During the vegetative state of the cannabis plants growth cycle, it needs a significant amount of what depending on its genetics?",4,Light and Nutrients,Water and Light,Water and Darkness,Humidity and Nutrients,1,1
,,,,,,2,Multiple Choice,Science of Cannabis,Which terpenoid helps to increase energy and mental focus?,4,Limonene,Myrcene,Pinene,Linalool,3,1
,,,,,,2,Multiple Choice,Strains,"If you have smoked a joint of ""Blue Dream"" for insomnia, then you have been affected by what type of terpene?",4,Limonene,Delta 3 Carene,Myrcene,Linalool,3,1
,,,,,,2,Multiple Choice,Science of Cannabis,"When marijuana is smoked, from which organ is THC passed into the bloodstream?",4,Liver,Mouth,Kidneys,Lungs,4,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,"In 2015, what states legsilators passed a limited medical cannabis law?",4,Louisiana,Arkansas,Mississippi,Texas,1,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,Which Canadian cannabis activist founded the Marijuana Party of Canada in 2000?,4,Marc-Boris St-Maruice,Blair Longley,Marc Emery,None of the Above,1,1
,,,,,,2,Multiple Choice,History,"In 1970, Congress passed which of the following acts?",4,Marihuana Tax Act,Controlled Substances Act,Scheduled Substances Act,None of the Above,2,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,"In 2008, what state approved a ballot measure to decriminalize cannabis?",4,Massachusetts,New York,Maine,Michigan,1,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,"In 2008, what state approved a ballot to legalize medical cannabis?",4,Massachusetts,New York,Maine,Michigan,4,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,"In 2018, what state approved a ballot measure to legalize the recreational use of cannabis?",4,Michigan,Texas,Utah,MIssouri,1,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,"In 2014, what two states legalized medical cannabis through their states legislatures?",4,Minnesota and New York,New York and New Jersey,Vermont and Colorado,Nevada and Nebraska,1,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,"In 2014, what state decriminalized cannabis through the state legislature?",4,Mississippi,Minnesota,Missouri,Colorado,2,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,What state legalized medical cannabis through a ballot measure in 2004?,4,Montana,Vermont,Nevada,California,1,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,What state legalized medical cannabis through the state legislature in 2004?,4,Montana,Vermont,Wisconsin,Missouri,2,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,"In 2006, which state legalized medical cannabis through the state legislature?",4,Montana,Rhode Island,Vermont,North Dakota,2,1
,,,,,,2,Multiple Choice,Science of Cannabis,The benefits of autoflowering cannabis seeds are:,4,More resistant to cold and temperature changes,Can be grown year round as long as it doesn't become too cold,It is a reliable and timely crop every time,All the above,4,1
,,,,,,2,Multiple Choice,Cannabis Culture,"This 2018 documentary on Netflix was about the big business of marijuana and the history of growing it in Humboldt County, California. Name the documentary.",4,Murder Mountain,On the Hill,Mary Jane Mountain,Hemp Hill,1,1
,,,,,,2,Multiple Choice,Science of Cannabis,Which terpenoid produces calming effects?,4,Myrcene,Pinene,Linalool,Limonene,3,1
,,,,,,2,Multiple Choice,Science of Cannabis,Which terpenoid helps to reduce pain and anxiety?,4,Myrcene,Pinene,Linalool,Limonene,4,1
,,,,,,2,Multiple Choice,Science of Cannabis,Which terpenoid produces calming effects?,4,Myrcene,Pinene,Linalool,Limonene,3,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,Cannabis is as common as grass in what country?,4,Nepal,Kingdom of Bhutan,Bangladesh,China,2,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,What state became the first to legalize medical cannabis through the state legislature?,4,Nevada,Hawaii,California,Colorado,2,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,"In 2012, what state legalized medical cannabis through the state legislature?",4,Nevada,Delaware,Connecticut,Idaho,3,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,"In the year 2000, which two states legalized medical cannabis through a ballot measure?",4,Nevada and California,Colorado and Nevada,Nevada and Washington,Oregon and Nevada,2,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,"In 2013, what state decriminalized cannabis through the state legislature?",4,New York,Utah,Nevada,Vermont,4,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,"In 2017, which state legalized the use of medical cannabis through the state legsilature?",4,New York,West Virginia,Ohio,Nevada,2,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,"In 2010, what state legalized medical cannabis through the state legislature?",4,New York,West Virginia,Florida,New Jersey,4,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,"In 2011, what state decriminalized cannabis through the state legislature?",4,New York,"Washington, D.C.",Connecticut,Delaware,3,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,"In 2013, what state decriminalized cannabis through the state legislature?",4,New York,Vermont,Utah,Nevada,2,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,In which state did Governor Andrew Cuomo sign legislation permitting the use of cannabis for medical purposes?,4,New York,California,Pennsylvania,Colorado,1,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,Which state decriminalized cannabis in 1976?,4,New York,Maine,California,None of the Above,4,1
,,,,,,2,Multiple Choice,Science of Cannabis,"According to a January 2018 article by Civilized., what African countries produces the most weed in Africa?",4,Nigeria,Morocco,Ethiopia,Kenya,2,1
,,,,,,2,Multiple Choice,Science of Cannabis,THCA is the acidic parent of the THC cannabinoid that is found in the raw cannabis plant.  What is THCA particularly useful for?,4,None of the Above,Appetite suppresant,Reducing cancerous cells,Creating a euphoric effect,1,1
,,,,,,2,Multiple Choice,Science of Cannabis,"As harvest cannbis ages, THC will gradually be converted to what cannabionid?",4,None of the Above,CBG,THCV,CBD,1,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,In what Canadian Province is it legal to consume cannabis in public where tobacco is also smoked?,4,Nova Scotia,All of the Above,Alberta,Ontario,2,1
,,,,,,2,Multiple Choice,Methods of Consumption,Josh Kesselman introduced these rolling papers to the market in 2005.,3,OCB,TOP,RAW,,3,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,What state legalized the medical use of cannabis through a ballot measure in 2017?,4,Oklahoma,Texas,Arizona,Nevada,1,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,Which state allowed up to life sentences for possession of marijuana in 1931?,4,Oklahoma,Kansas,Texas,Nebraska,3,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,In the 2001 what state decriminalized cannabis through the state legislature?,4,Oregon,California,Nevada,Washington,3,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,"In 1998, what 3 states legalized medical cannabis through a ballot measure?",4,"Oregon, Alaska, and Nevada","Washington, Nevada, and Oregon","Oregon, Alaska, and Washington","Oregon, Alaska, and Washington",3,1
,,,,,,2,Multiple Choice,Cannabis Culture,"A native Californian has toured with one of the most iconic rock bands in the world, is apart of the Rock & Roll Hall of Fame, Songwriters Hall of Fame, and is also on the advisory board for the National Organization for the Reform of Marijuana Laws (NORML).",4,Ozzy Osbourne,David Crosby,Phil Collins,Melissa Etheridge,2,1
,,,,,,2,Multiple Choice,History,Hemp was exchanged as legal tender in which of these states in 1619?,4,Pennsylvania,Virginia,Maryland,All of the Above,4,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,What two states legalized the medical use of cannabis through the state legsilature in 2016?,4,Pennsylvania and Ohio,Ohio and Indiana,Illinois and Indiana,Kentucky and Ohio,1,1
,,,,,,2,Multiple Choice,Cannabis Culture,"Which of these famous painters were quoted as saying ""I think pot should be legal.  I don't smoke it, but I like the smell of it.""",4,Peter Saul,Joe Tilson,Andy Warhol,John Wesley,3,1
,,,,,,2,Multiple Choice,Science of Cannabis,Which terpenoid contains anti-depressant and anti-inflammatory properties?,4,Pinene,Myrcene,Limonene,Linalool,2,1
,,,,,,2,Multiple Choice,Science of Cannabis,Which terpenoid helps to increase energy and mental focus?,4,Pinene,Limonene,Linalool,Myrcene,1,1
,,,,,,2,Multiple Choice,Science of Cannabis,Which terpenoid helps to reduce pain and anxiety?,4,Pinene,Limonene,Linalool,Myrcene,1,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,"What is the name of the first retail dispensary to open in Clark County, NV in 2015",4,Planet 13,Essence,Las Vegas ReLeaf,Euphoria Wellness,4,1
,,,,,,2,Multiple Choice,Strains,"When crossing East Coast Panama Chunk and Sour Diesel you get 3rd Coast Panama Chunk, which is considered what type of strain?",4,Sativa Dominant Hybrid,Indica Dominant Hybrid,Indica,Sativa,1,1
,,,,,,2,Multiple Choice,Strains,"A popular Sativa-dominant strain combined with Haze hybrid, Northern Lights #5 and Shiva Skunk cross was named after which celebrity cannabis advocate?",4,Snoop Dogg OG,Chuck Norris Black and Blue Dream,Obama Kush,Jack Herer,4,1
,,,,,,2,Multiple Choice,Cannabis Culture,Who founded the Boston Freedom Rally?,4,Steven Hager,Tommy Chong,Keith Stroup,Linda Noel,4,1
,,,,,,2,Multiple Choice,Science of Cannabis,"The endocannabinoid system helps to regulate a lot of important functions within the human body, such as ________, __________, and ____________.",4,"temperature regulation, mood, and immune function","muscle memory, appetite, and bone density","libido, motor control, and digestion",,1,1
,,,,,,2,Multiple Choice,Science of Cannabis,"When THCA is exposed to heat, it is converted to:",4,THCV,THCA,THC,CBD,3,1
,,,,,,2,Multiple Choice,Cannabis Culture,What is the name of Barack Obama's pot-smoking college group of friends?,4,The Choom Gang,Noobie Doobies,The Pot Head Alliance,Mary Jane's Brothers,1,1
,,,,,,2,Multiple Choice,History,"This marijuana freedom fighter marched into the San Francisco Hall of Justice on August 16, 1914, lit a joint and puffed it in the presence of the police inspector.",4,Tom Forcade,Tommy Chong,Lowell Eggmeier,Allen Ginsberg,3,1
,,,,,,2,Multiple Choice,Cannabis Culture,Who helped Snoop Dogg obtain his first medical marijuana recommendation?,4,Tommy Chong,Nancy Botwin,Dina Browner,None of the Above,3,1
,,,,,,2,Multiple Choice,Facts and Myths,Who created the Hemp Car that ran on Hemp Ethanol?,4,Tommy Chong,Elon Musk,Henry Ford,Bill Gates,3,1
,,,,,,2,True/False,Cannabis Culture,"On April 5, 2018, Green Rush Daily Inc. acquired cannabis magazine High Times.",2,True,False,,,2,1
,,,,,,2,True/False,Cannabis Culture,Bob Brandel directed High Times Magazine's documentary film Let Freedom Ring.,2,True,False,,,1,1
,,,,,,2,True/False,Cannabis Terms and Definitions,Ganja comes from the swahili word for hemp.,2,True,False,,,2,1
,,,,,,2,True/False,Cannabis Terms and Definitions,Endocannabinoid is defined as several chemical compounds that are naturally produced within the body and bind to the same brain receptors as compounds derived from cannabis.,2,True,False,,,1,1
,,,,,,2,True/False,Cannabis Terms and Definitions,"Cannabinoid is defined as various naturally-occuring, biologically active, chemical consitutents of hemp or cannabis including some that possess psychoactive properties.",2,True,False,,,1,1
,,,,,,2,True/False,Cannabis Terms and Definitions,"The term ""420"" came about because marijuana was said to be smoked the most on April 20th because it was an ""Earthly Day"".",2,True,False,,,2,1
,,,,,,2,True/False,Facts and Myths,Hemp requires minimal care and can grow in most climates.,2,True,False,,,1,1
,,,,,,2,True/False,Facts and Myths,"The ropes, sails, and caulking of the Mayflower were all made from hemp fiber.",2,True,False,,,1,1
,,,,,,2,True/False,Facts and Myths,Hemp has lower concentrations of THC and higher concentrations of cannabidiol,2,True,False,,,1,1
,,,,,,2,True/False,Facts and Myths,"In 2011, an article was published that a U.S. marshal sweeps through the greenhouses in Antarctica so no one grows weed there.",2,True,False,,,1,1
,,,,,,2,True/False,Facts and Myths,"Spiders high on marijuana spun highly geometric webs, even more so than when they were sober. Spiders high on LSD, on the other hand, built messy webs, were easily distracted, and gave up easily. ",2,True,False,,,2,1
,,,,,,2,True/False,Science of Cannabis,The Deep Water Culture hydroponic growing system is great for beginner cannabis growers.,2,True,False,,,1,1
,,,,,,2,True/False,Science of Cannabis,Autoflowering cannabis strains tend to produce much smaller yields than cannabis grown the standard way.,2,True,False,,,1,1
,,,,,,2,True/False,Science of Cannabis,The Drip hydroponic growing system is the most widely known and used grow system in the world.,2,True,False,,,1,1
,,,,,,2,True/False,Science of Cannabis,Humidity is NOT an important factor in cannabis plant growth.,2,True,False,,,2,1
,,,,,,2,True/False,Science of Cannabis,"Germination is a process where the seeds sprout and the root emerges, with Cannabis it can take anywhere from 12 hours to 8 days.",2,True,False,,,1,1
,,,,,,2,True/False,Science of Cannabis,When the seed coat splits open to expose the root and cotyledons is called the seedling phase.,2,True,False,,,1,1
,,,,,,2,True/False,Science of Cannabis,"The pre-flowering phase is also referred to as the stretch, and it can take as little as one day or up to two weeks.",2,True,False,,,1,1
,,,,,,2,True/False,Legal Cannabis Worldwide,METRC doesn't allow regulators to view all licensee activities and inventory to track trends and assist in compliance.,2,True,False,,,2,1
,,,,,,2,True/False,Legal Cannabis Worldwide,"When you buy an eight of weed at a dispensary, it is 7 grams.",2,True,False,,,2,1
,,,,,,2,True/False,Legal Cannabis Worldwide,The legal possesion limit in California is 28.5 grams of marijuana flower and up to 8 grams of marijuana concentrate,2,True,False,,,1,1
,,,,,,2,True/False,Legal Cannabis Worldwide,"A customer's medical condition, purchase history and consumption habits are considered confidential information.",2,True,False,,,1,1
,,,,,,2,True/False,Legal Cannabis Worldwide,Dispensaries have access to consumer medical records.,2,True,False,,,2,1
,,,,,,2,True/False,Legal Cannabis Worldwide,Dispensaries do not have access to consumer medical records.,2,True,False,,,1,1
,,,,,,2,True/False,Legal Cannabis Worldwide,At no time will a medical consumer's confidential information may be released at any time to a third party without the consumer or caregiver's expressed written consent.,2,True,False,,,1,1
,,,,,,2,True/False,Legal Cannabis Worldwide,A medical marijuana patient with a Washington state ID and a medical marijuana recommendation may purchase medical marijuana from a Nevada dispensary. ,2,True,False,,,2,1
,,,,,,2,True/False,Legal Cannabis Worldwide,"In Canada, it is legal to share up to 30 grams of legal cannabis with other adults.",2,True,False,,,1,1
,,,,,,2,True/False,Legal Cannabis Worldwide,"In the Alberta, a Canadian province, adults can possess up to 30 grams of legally produced cannabis in public.",2,True,False,,,1,1
,,,,,,2,True/False,Legal Cannabis Worldwide,"In Manitoba, a Canadian province, consumption is only allowed in private homes and prohibited in all public spaces",2,True,False,,,1,1
,,,,,,2,True/False,Legal Cannabis Worldwide,"In New Brunswick, a Canadian province, Cannabis NB is the only legal retailer.",2,True,False,,,1,1
,,,,,,2,True/False,Legal Cannabis Worldwide,Medicinal use of marijuana is permitted in the state of North Dakota.,2,True,False,,,1,1
,,,,,,2,True/False,Legal Cannabis Worldwide,"In Alberta, Canada, public consumption laws are the same as smoking or using tobacco, although smoking near children is considered illegal.",2,True,False,,,1,1
,,,,,,2,True/False,Legal Cannabis Worldwide,"It is ILLEGAL to grow cannabis in your home in Alberta, Canada.",2,True,False,,,2,1
,,,,,,2,True/False,Methods of Consumption,The two main methods of cannabis extraction are known as solvent-based extraction and non-solvent extraction.,2,True,False,,,1,1
,,,,,,2,True/False,Methods of Consumption,Smoking hashish was a highly popular in the Middle East during the 12th Century.,2,True,False,,,1,1
,,,,,,2,True/False,Methods of Consumption,"Unlike edibles or drinks containing cannabis extract, Tinctures are immediately absorbed into the bloodstream",2,True,False,,,1,1
,,,,,,2,True/False,Methods of Consumption,Dabbing is not a form of vaporization,2,True,False,,,2,1
,,,,,,2,True/False,Methods of Consumption,The gum adhesive used in Bambu rolling papers is made from the African Acacia tree.,2,True,False,,,1,1
,,,,,,2,True/False,Methods of Consumption,"Considered to be the world's first ""vegan"" rolling papers, RAW is made from the hemp plant itself.",2,True,False,,,1,1
,,,,,,2,True/False,Legal Cannabis Worldwide,"Justin Trudeau, who became the Canadian Prime Minister in 2015, made marijuana legalization in Canada a key part of his campaign. ",2,True,False,,,1,1
,,,,,,2,True/False,Science of Cannabis,All animals have endocannabinoid systems.,2,True,False,,,1,1
,,,,,,2,True/False,Science of Cannabis,Cannabis belongs to the Cannabaceae family.,2,True,False,,,1,1
,,,,,,2,True/False,Science of Cannabis,Marijuana deposits about 5 times as musch tar in the lungs than tobacco smoking does.,2,True,False,,,1,1
,,,,,,2,True/False,Science of Cannabis,Most people harvest their marijuana plants when the trichomes are mostly milky-white from clear with a pronounced amber in some of the crystals.,2,True,False,,,1,1
,,,,,,2,True/False,Science of Cannabis,"Dr. Xia Zhang at the University of Saskatchewan successfully showed that cannabinoids cause something called ""neurogensis"" to occur, meaning they help make new brain cells grow.",2,True,False,,,1,1
,,,,,,2,True/False,Science of Cannabis,The activation boiling point for the a-Pinene terpene is 311F,2,True,False,,,1,1
,,,,,,2,True/False,Science of Cannabis,"A humulus plant is related to cannabis and is known as a ""Cannabaceae"".",2,True,False,,,1,1
,,,,,,2,True/False,Science of Cannabis,"The terpene Myrcene is known to aid in pain management, as well as treatment for insomnia and pain.",2,True,False,,,1,1
,,,,,,2,True/False,Science of Cannabis,"Edibles which are held in the mouth or applied under the tongue such as tinctures, will be absorbed through the liver.",2,True,False,,,2,1
,,,,,,2,True/False,Science of Cannabis,"THC increases beta-amyloid ""brain plaque"" increasing the chance to develop Alzheimer's or dementia.",2,True,False,,,2,1
,,,,,,2,True/False,Science of Cannabis,"The terpene Myrcene is known to aid in the treatment of depression, eating disorders, and inflammation.",2,True,False,,,2,1
,,,,,,2,True/False,Science of Cannabis,"The terpene a-Pinene is known to aid in the treatment of asthma, pain, depression, anti-fungal, anxiety, and cancer.",2,True,False,,,2,1
,,,,,,2,True/False,Science of Cannabis,The activation boiling point for the Myrcene terpene is 332F.,2,True,False,,,1,1
,,,,,,2,True/False,Science of Cannabis,"A potential effect of the Myrcene terpene include an uplifting, euphoric effect that can aid in the treatment of depression.",2,True,False,,,2,1
,,,,,,2,True/False,Science of Cannabis,"Edibles that are chewed and swallowed, such as cookies or cakes, are absorbed gastrointestinally.",2,True,False,,,1,1
,,,,,,2,True/False,Science of Cannabis,"When edibles are absorbed sublingually, one can expect an onset time of 5-30 minutes and feel the effects from the product for about 2-4 hours.",2,True,False,,,1,1
,,,,,,2,True/False,Science of Cannabis,It takes 10 seconds for marijuana to reach peak levels in the brain.,2,True,False,,,2,1
,,,,,,2,True/False,Science of Cannabis,It possible to overdose on marijuana.,2,True,False,,,1,1
,,,,,,2,True/False,Science of Cannabis,Cannabis and beer are related.,2,True,False,,,2,1
,,,,,,2,True/False,Science of Cannabis,"THC and CBD have identical molecular structures, however there is a slight difference in how the atoms are arranged which accounts for the differing impacts on the body.",2,True,False,,,1,1
,,,,,,2,True/False,Science of Cannabis,"According to the California Medical Association (CMA), cannabis is most effective in treating chronic pain from nerve injury or disease.",2,True,False,,,1,1
,,,,,,2,True/False,Science of Cannabis,"Some of the potential effects of the a-Pinene terpene include alertness, memory retention, and it can also enhance some of the effects of THC.",2,True,False,,,2,1
,,,,,,2,True/False,Science of Cannabis,The endocannabinoid system is made up of 4 parts.,2,True,False,,,2,1
,,,,,,2,True/False,Science of Cannabis,"The a-Pinene terpene can also be found in pine needles, rosemary, basil, parsley, and dill.",2,True,False,,,1,1
,,,,,,2,True/False,Science of Cannabis,"The a-Pinene terpene can also be found in mangos, basil, rosemary, lemongrass, and thyme.",2,True,False,,,2,1
,,,,,,2,True/False,Science of Cannabis,"The Myrcene terpene can smell a bit like cardamom, cloves, a bit musky, earthy, and herbal.",2,True,False,,,1,1
,,,,,,2,True/False,Science of Cannabis,"The Myrcene terpene produces a fruity, pine like scent.",2,True,False,,,2,1
,,,,,,2,True/False,Science of Cannabis,The activation boiling point for the Myrcene terpene is 254F.,2,True,False,,,2,1
,,,,,,2,True/False,Science of Cannabis,"A potential effect of the Myrcene terpene include a sedating ""couchlock"" effect.",2,True,False,,,1,1
,,,,,,2,True/False,Science of Cannabis,"The Myrcene terpene can also be found in Mango, lemongrass, thyme, and hops.",2,True,False,,,1,1
,,,,,,2,True/False,Science of Cannabis,"The Myrcene terpene can also be found in Lavender, pine needles, thyme, and pepper.",2,True,False,,,2,1
,,,,,,2,True/False,Science of Cannabis,Marijuana does not treat severe pain,2,True,False,,,2,1
,,,,,,2,True/False,Science of Cannabis,Marijuana does not reduce nausea induced by cancer chemotherapy,2,True,False,,,2,1
,,,,,,2,True/False,Science of Cannabis,THC is the non-intoxicating compound found in the cannabis plant,2,True,False,,,2,1
,,,,,,2,True/False,Science of Cannabis,THCA and CBDA are normally the most abundant cannabinoids in strains,2,True,False,,,1,1
,,,,,,2,True/False,Science of Cannabis,Plant cannabinoids are made from cannabinoid acids,2,True,False,,,1,1
,,,,,,2,True/False,Science of Cannabis,Plant cannabinoids are not made from cannabinoid acids,2,True,False,,,2,1
,,,,,,2,True/False,Science of Cannabis,"When THCA is exposed to heat, it is converted to THC",2,True,False,,,1,1
,,,,,,2,True/False,Science of Cannabis,"When THCA is exposed to heat, it is converted to CBD",2,True,False,,,2,1
,,,,,,2,True/False,Science of Cannabis,There are 5 main ways to grow cannabis.,2,True,False,,,2,1
,,,,,,2,True/False,Strains,98 Aloha White Widow is a phenotype from the White Widow plant.,2,True,False,,,1,1
,,,,,,2,True/False,Strains,"501st OG is known for its colorful flowers that are a beautiful mixture of green, blue, red, and purple.",2,True,False,,,1,1
,,,,,,2,True/False,Strains,Kosher Tangie aka 24k Gold is a hybrid strain that typically contains 18-24% THC.,2,True,False,,,1,1
,,,,,,2,True/False,Strains,"Jack Herer is a sativa-dominant strain combined with Haze hybrid, Northern Lights #5 and Shiva Skunk cross",2,True,False,,,1,1
,,,,,,2,True/False,Strains,Kosher Kush is a sativa-dominant hybrid,2,True,False,,,2,1
,,,,,,2,True/False,Legal Cannabis Worldwide,"In the state of Nevada, a Medical Marijuana cardholder who is at least 18 years or older can purchase up to 2.5 ounces of useable marijuana.",2,True ,False,,,1,1
,,,,,,2,Multiple Choice,Strains,Which strain won the High Times Cannabis Cup both in 1998 and 1999?,4,True OG,Tangie,Super Sliver Haze,Flowerbomb Kush,3,1
,,,,,,2,Multiple Choice,Cannabis Culture,"According to a 2018 article by The Princeton Review, what university has the highest student rating on marijuana use for 2017 and 2018?",4,University of Vermont,Yale,University of Colorado,Florida State University,1,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,"What state became the first in the nation to pass a low-THC, high-CBD medical cannabis law?",4,Utah,Nevada,Idaho,Montana,1,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,"Expanding on the limited measure passed in 2003, what states legislators decriminalized cannabis and approved a comprehensive medical cannabis law?",4,Utah,Maryland,Nevada,California,2,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,"In 1979, what state passed legislation allowing doctors to recommend cannabis for glaucoma or for the side effects of chemo therapy?",4,Utah,Alaska,Nebraska,Virginia,4,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,Which state's legislators made the use and cultivation of cannabis a misdemeanor in 1917?,4,Vermont,Colorado,California,North Dakota,2,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,"In 2010, what state legislators in what state reduced penalties for cannabis to a civil infraction?",4,Washington,Nevada,California,Oregon,3,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,Amendment 64 was a measure outlining a statewide drug policy for cannabis to amend the Constitution of what state?,4,Washington,California,Nebraska,Colorado,4,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,"The economic impact of legalizing cannabis is quite impressive, what state collected more than $135 million in taxes and fees from the sale of medical and recreational cannabis in 2015?",4,Washington,Oregon,California,Colorado,4,1
,,,,,,2,Multiple Choice,Legal Cannabis Worldwide,Initiative 502 (I-502) was an initiative to legalize small amounts of marijuana-related products for adults 21 years or older for individuals in what state?,4,Washington,Colorado,California,Nebraska,1,1
,,,,,,2,Multiple Choice,Science of Cannabis,"CBDA is the acidic parent of CDB that is found in the raw cannabis plant, how is it converted to CBD?",4,When the flower is harvested off of the cannabis plant,"When it is left in a cool, damp, dark place",None of the above,When it is frozen,3,1
,,,,,,2,Multiple Choice,Strains,Which of the following strains is a phenotype of White Widow?,4,White Rhino,Bubba Kush,98 Aloha White Widow,OG Kush,3,1
,,,,,,2,Multiple Choice,Cannabis Culture,This Emmy Award winning actor sits on the advisory board for The National Organization for the Reform of Marijuana Laws (NORML).,4,Woody Harrelson,Matthew Rhys,Henry Winkler,Don Cheadle,1,1
,,,,,,2,Multiple Choice,Methods of Consumption,"In 2009, this rolling paper company sued the FDA in order to protect their products within the US marketplace.",4,Zig Zag,RAW,TOP,Juicy Jay's,4,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,1,,7,3,Multiple Choice,Science of Cannabis,How long do cannabis plants need to be exposed to light during the vegetative state?,4,12 hours,8 hours,18 hours,24 hours,3,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,1,,1,3,Multiple Choice,History,In what year did the United States government categorize cannabis as a Schedule 1 drug?,4,1970,1932,1975,None of the Above,1,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,1,,2,3,Multiple Choice,Cannabis Culture,Aaron Smith and Steve Fox founded the National Cannabis Industry Association in what year?,4,1997,2005,1971,2010,4,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,1,,6,3,Multiple Choice,Legal Cannabis Worldwide,Pharmacies are the only legal establishment to purchase cannabis in what country?,4,Canada,Uruguay,The United Kingdom,Chile,2,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,1,,8,3,Multiple Choice,Strains,Which of the following strains is not a sativa-dominant hybrid?,4,Chemdog 4,ACDC,White Fire OG,Double Dream,1,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,1,,9,3,Multiple Choice,Science of Cannabis,"What cannabinoid did neuroscientist Dr. Chuanhai Cao discover in a 2014 study on the effects of cannabis and Alzheimer's disease, directly affects Alzheimer's pathology by decreasing its amyloid beta levels?",4,THC,THCV,CBD,None of the Above,1,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,2,,5,3,Multiple Choice,History,In what year did the first marijuana freedom protest happen?,2,1971,1976,1964,None of the Above,3,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,2,,8,3,Multiple Choice,Science of Cannabis,Which of the following elements are known as MICROELEMENTS needed for the healthy growth of cannabis plants?,4,Copper (Cu),Zinc (Zn),Boron (B),All of the Above,4,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,2,,9,3,Multiple Choice,Strains,Which of the following strains is a sativa-dominant hybrid?,4,Critical Mass,Purple Gorilla,Pink Lemonade,Remedy,3,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,2,,2,3,Multiple Choice,Strains,"Which strain is mixed with Chem's Sister, Sour Dubb and Chocolate Diesel?",4,Gorilla Cookies,Original Glue,Purple Gorilla,Godzilla Glue,2,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,2,,4,3,Multiple Choice,Science of Cannabis,Which of the following is NOT a piece of equipment used for cultivating cannabis?,4,Humidifier,pH and PPM meters,Swamp Cooler,Magnifying Glass,3,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,2,,6,3,True/False,History,The oldest known written record of consuming cannabis comes from Chinese Emperor Shen Nung.,2,True,False,,,1,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,2,,1,3,True/False,Science of Cannabis,"THC is absorbed through the liver when ingested, here is where delta-9 THC metabolizes into 11-hydroxy THC.",2,True,False,,,1,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,2,,3,3,True/False,Science of Cannabis,"When growing cannabis hydroponically, the water acts as the soil.",2,True,False,,,1,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,3,,6,3,Multiple Choice,Cannabis Culture,Nora Callahan founded the November Coalition in what year?,4,1997,1995,2007,2015,1,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,3,,2,3,Multiple Choice,Cannabis Culture,What is the name of the marijuana legalization group started by High Times Editor-In-Chief Steven Hager?,4,Cannabis Culture,420 Angels,Green Panthers,High Times Freedom Fighters,4,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,3,,10,3,Multiple Choice,Cannabis Culture,"Which of these NBA owners were quoted as saying about the legalization of cannabis, ""Yes.  And release prisoners who are incarcerated for pot.""",4,Herbert Simon,Mark Cuban,Peter Holt,Gail Miller,2,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,3,,7,3,Multiple Choice,Science of Cannabis,What element is essential for early plant growth?,4,Nitrogen,Phosphorus ,Zinc,Potassium,4,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,3,,8,3,Multiple Choice,Legal Cannabis Worldwide,"Which of the following was a proposition voted in by Californians that would alow adults age 21 and over to possess, grow, and use marijuana?",4,Prop 420,Prop 502,Prop 64,Prop 512,3,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,3,,1,3,True/False,Methods of Consumption,"Using ice to chill cannabis flowers to sub-zero temperatures, agitating the resin glands to detach from the epidermis of the flowers is considered solvent-based extraction.",2,True,False,,,2,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,3,,3,3,True/False,Science of Cannabis,"THC slows the formation of amyloid plaques in the brain by blocking an enzyme that makes them, slowing the progression of Alzheimer's disease.",2,True,False,,,1,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,4,,2,3,Multiple Choice,Science of Cannabis,What cannabinoids are best to use when trying to manage nerve pain?,4,CBDA and THCA,CBD and CBDA,THCV and THCA,None of the Above,4,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,4,,4,3,Multiple Choice,History,Ancient Romans boiled the roots of the cannabis plant and used them for which of these treatments?,4,Generalized pain,Gout,Arthritis,All of the Above,4,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,4,,10,3,Multiple Choice,Cannabis Culture,"This noteable United States Vice President was quoted saying, ""I smoked pot in college, and in the Army...""",4,George Bush,Al Gore,Dan Quayle,Joe Biden,2,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,4,,1,3,Multiple Choice,Science of Cannabis,Which cannabinoid was discovered to stop metastasis in aggressive forms of cancer?,4,None of the Above,THC,CBD,THCV,3,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,4,,5,3,Multiple Choice,Cannabis Culture,"Which of these American Presidents were quoted saying, ""I now have absolute proof that smoking even one marijuana cigarette is equal in brain damage to being on Bikini Island during an H-bomb blast.""",4,Richard Nixon,George Bush,Ronald Reagan,Donald Trump,3,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,4,,6,3,Multiple Choice,Methods of Consumption,"Utilizing pure light aliphatic nnaphtha to remove resin containing the cannabinoids, leaving behind a dark, thick product with THC levels upwards of 90%, this product is often used for medicinal purposes.",4,Rick Simpson Oil (RSO),Butane Hash Oil (BHO),Propane Hash Oil (PHO),CO2 Oil,1,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,4,,7,3,Multiple Choice,Science of Cannabis,"Researches at California Pacific Medical Center in San Francisco, reported findings that what cannabinoid may prevent cancer from spreading?",2,THCV,CBD,THC,None of the Above,2,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,5,,10,3,Multiple Choice,Cannabis Culture,Robert C. Randall and Alice O'Leary founded the Alliance for Cannabis Therapeutics in what year?,4,1981,1970,1992,1993,1,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,5,,2,3,Multiple Choice,Science of Cannabis,Which boiling activation point is appropriate for THC-A?,4,220 Degrees Fahrenheit,356 Degrees Fahrenheit,428 Degrees Fahrenheit,311 Degrees Fahrenheit,1,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,5,,6,3,Multiple Choice,Strains,"Of the choices below, which would you recommend to a customer with inflammation issues?",3,Girl Scout Cookies,Liberty Haze,Mazar x Blueberry OG,,1,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,5,,8,3,True/False,History,It's been said that marijuana was an ingredient in a holy anointing oil referenced in the original Hebrew version of Exodus.,2,True,False,,,1,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,5,,1,3,True/False,Legal Cannabis Worldwide,"Canadian company Tilray (TLRY) became the first marijuana IPO in the United States, and began trading on the Nasdag on July 19, 2018",2,True,False,,,1,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,5,,3,3,True/False,Science of Cannabis,"11-hydroxy THC is 3-4 times more potent than delta-9 THC, and better at crossing the blood-brain barrier.",2,True,False,,,1,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,5,,7,3,True/False,Science of Cannabis,"To begin the flowering stage in cannabis, switch the light cycle to 12 hours of light and 12 hours of dark.",2,True,False,,,1,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,6,,2,3,Multiple Choice,Cannabis Culture,"Steve Kubby, Ed Rosenthal, and Tod H. Mikuriya founded the American Medical Marijuana Association in what year?",4,1980,1999,1995,2001,2,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,6,,7,3,Multiple Choice,Cannabis Culture,Terry Mitchell and Loey Glover founded the Green Panthers in what year?,4,1995,1996,1990,1981,3,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,6,,5,3,Multiple Choice,Science of Cannabis,The optimum root zone pH level for soilless growing mediums such as hydro or coco coir is:,4,5.5-6.5 pH,6.0-7.0 pH,4.2-5.5 pH,None of the Above,1,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,6,,3,3,Multiple Choice,Strains,"Of the choices below, which strain would you recommend to a customer that struggles with insomnia?",3,Blue Dream,Lemon Haze,Harlequin,,3,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,6,,10,3,Multiple Choice,Strains,"Of the choices below, which strain would you recommend to a customer looking for stress relief?",3,Jack Herer,Lemon G,Dutch Treat,,2,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,6,,2,3,Multiple Choice,Science of Cannabis,This element activates many of the cannabis plant's enzymes that are required for plant growth.,4,Sulfur,Calcium,Magnesium,Potassium,3,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,6,,8,3,Multiple Choice,Science of Cannabis,The element Phosphorus is important for the creation of what?,4,Terpenes,Giving marijuana its flavor,Plant sugars,All of the Above,4,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,6,,6,3,True/False,History,"On September 10, 1914, the first raid on marijuana happened in the Mexican Sonoratown neighborhood of Los Angeles, CA.",2,True,False,,,1,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,7,,3,3,Multiple Choice,History,"The United States first ""marihuana"" raid happened in the Mexican Sonoratown neighborhood of Los Angeles, CA in what year?",4,1914,1910,1937,1976,1,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,7,,4,3,Multiple Choice,Cannabis Culture,Tod H. Mikuriya founded the Society of Cannabis Clinicians in what year?,4,1995,2004,2007,1984,2,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,7,,5,3,Multiple Choice,Science of Cannabis,Which boiling activation point is appropriate for THC?,4,220 Degrees Fahrenheit,365 Degrees Fahrenheit,388 Degrees Fahrenheit,315 Degrees Fahrenheit,4,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,7,,1,3,Multiple Choice,Science of Cannabis,The element Phosphorus is important as it helps the plant transform solar energy into what?,4,Celular energy,Kinetic energy,Chemical energy,None of the Above,3,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,7,,3,3,Multiple Choice,Science of Cannabis,Which of the following elements are known as MACROELEMENTS when growing cannabis?,4,Potassium (K),Phosphorus (P),Nitrogen (N),All of the Above,4,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,7,,10,3,Multiple Choice,Science of Cannabis,What is the name of the precursor molecule that is turned into THCA and CBDA as the cannabis plant develops?,4,THC,THCV,CBD,None of the Above,4,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,7,,9,3,Multiple Choice,Science of Cannabis,Kim Janda of Scripps Research Institute discovered what cannabinoid helped slow the progression of Alzheimer's disease?,4,THCA,CBD,THCV,THC,4,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,7,,7,3,True/False,Science of Cannabis,Magnesium is a part of chlorophyll in all plants.,2,True,False,,,1,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,8,,1,3,Multiple Choice,Cannabis Culture,Martin H. Chilcutt founded Veterans for Medical Cannabis Access in what year?,4,2004,2007,1989,1999,2,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,8,,3,3,Multiple Choice,History,Who initially brought cannabis to the Americas?,4,Arab traders,Spaniards,The French,The Romans,2,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,8,,8,3,Multiple Choice,Science of Cannabis,Which terpenoids have anti-inflammatory properties?,4,Linalool & Limonene,Myrcene & Humulene,Pinene & B-Caryophyllene,Linalool & Myrcene,2,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,8,,5,3,Multiple Choice,History,"From 800 to 900 AD, the Arabians used cannabis for which of the following ailments?",4,Migraines,Pain,Syphilis,All of the Above,4,1
1,Master of Cannabis,Go head to head with other cannabis masters to see who comes out on TOP this month!,8,,6,3,True/False,History,The first modern Western scientist to study the chemical composition of cannabis indica is Dr. William B. O'Shaugnessy.,2,True,False,,,1,1
,,,,,,3,True/False,Science of Cannabis,The activation point for the a-Pinene terpene is 320F,2,True,False,,,2,1
,,,,,,3,True/False,Science of Cannabis,"If the temperature in the grow room goes below 80 degrees during the vegetative phase of growth, the grower will need to up the amount of Nitrogen added.",2,True,False,,,1,1
,,,,,,3,True/False,Science of Cannabis,Lowering your reflector in a grow tent makes sure that your plants don't have to reach for the light.,2,True,False,,,1,1
)

products = Product.where(internal_name: %w(caned cantrivia))

products.each do |product|
  ActsAsTenant.with_tenant(product) do

    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      row["Topic"] = "Terpenoids and Cannabinoids" if row["Topic"] == "Terpenes and Cannabinoids"
      if row["Question Type"] == "True/False"
        question = Trivia::BooleanChoiceAvailableQuestion.where(title: row["Question"]).first_or_initialize
      else
        question = Trivia::SingleChoiceAvailableQuestion.where(title: row["Question"]).first_or_initialize
      end
      question.time_limit = 5
      question.cooldown_period= 10
      question.complexity = row["Complexity"]
      question.topic = Trivia::Topic.where(name: row["Topic"]).first
      question.published!
      question.save!

      (1..row["Number of Answers"].to_i).each do |index|
        question.available_answers.create(
          name: row["Answer #{index}"],
          is_correct: row["Correct Answer"].to_i == index,
          status: :published
        )
      end
    end
  end
end
