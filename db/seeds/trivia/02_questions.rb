require 'csv'
csv_text = %Q(Game,Game Name,Round Number,Question Order,Difficulty,Question Type,Topic,Question,Number of Answers,Answer 1,Answer 2,Answer 3,Answer 4,Correct Answer
,,,,2,Multiple Choice,Cannabis Freedom Fighters,The National Organization for the Reform of Marijuana Laws (NORML) was founded in 1970 by who?,4,Keith Stroup,Tommy Chong,Nancy Botwin,Alice O'Leary,1
,,,,2,Multiple Choice,Cannabis Freedom Fighters,Keith Stroup founded The National Organization for the Reform of Marijuana Laws (NORML) in what year?,4,1981,1972,1990,1970,4
,,,,2,Multiple Choice,Cannabis Freedom Fighters,Steph Sherer founded Americans for Safe Access in what year?,4,2001,2002,1999,1971,2
,,,,2,Multiple Choice,Cannabis Freedom Fighters,Jane West and Jazmin Hupp founded Women Grow in what year?,4,2010,1999,2014,2003,3
,,,,2,Multiple Choice,Laws and Regulations,"In 1975, which 5 states decriminalized cannabis?",4,"Alaska, Maine, Colorado, California, and Ohio","Nevada, California, Ohio, Alaska, and Main","Oregon, California, Ohio, Minnesota, and Nevada","Alaska, Nebraska, New York, Washington, and Oregon",1
,,,,2,Multiple Choice,Laws and Regulations,"In 1979, what state passed legislation allowing doctors to recommend cannabis for glaucoma or for the side effects of chemo therapy?",4,Utah,Alaska,Nebraska,Virginia,4
,,,,2,Multiple Choice,Laws and Regulations,"In 1998, what 3 states legalized medical cannabis through a ballot measure?",4,"Oregon, Alaska, and Nevada","Washington, Nevada, and Oregon","Oregon, Alaska, and Washington","Oregon, Alaska, and Washington",3
,,,,2,Multiple Choice,Laws and Regulations,Maine legalized medical cannabis through a ballot measure in what year?,4,1998,1996,1994,1999,4
,,,,2,Multiple Choice,Laws and Regulations,What state became the first to legalize medical cannabis through the state legislature?,4,Nevada,Hawaii,California,Colorado,2
,,,,2,Multiple Choice,Laws and Regulations,Hawaii became the first state in the US to legalize medical cannabis through the state legislature in what year?,4,2000,2001,1995,1996,1
,,,,2,Multiple Choice,Laws and Regulations,"In the year 2000, which two states legalized medical cannabis through a ballot measure?",4,Nevada and California,Colorado and Nevada,Nevada and Washington,Oregon and Nevada,2
,,,,2,Multiple Choice,Laws and Regulations,In what year did Nevada decriminalize cannabis through the state legislature?,4,2002,2000,2001,1996,3
,,,,2,Multiple Choice,Laws and Regulations,In the 2001 what state decriminalized cannabis through the state legislature?,4,Oregon,California,Nevada,Washington,3
,,,,2,Multiple Choice,Laws and Regulations,In what year did Vermont legalize medical cannabis through the state legislature?,4,2005,2006,2004,2007,3
,,,,2,Multiple Choice,Laws and Regulations,What state legalized medical cannabis through the state legislature in 2004?,4,Montana,Vermont,Wisconsin,Missouri,2
,,,,2,Multiple Choice,Laws and Regulations,In what year did Montana legalize medical cannabis through a ballot measure?,4,2002,1995,2009,2004,4
,,,,2,Multiple Choice,Laws and Regulations,What state legalized medical cannabis through a ballot measure in 2004?,4,Montana,Vermont,Nevada,California,1
,,,,2,Multiple Choice,Laws and Regulations,"In 2006, which state legalized medical cannabis through the state legislature?",4,Montana,Rhode Island,Vermont,North Dakota,2
,,,,2,Multiple Choice,Laws and Regulations,Rhode Island legalized medical cannabis through the state legislature in what year?,4,2005,1996,2006,2001,3
,,,,2,Multiple Choice,Laws and Regulations,In what year did New Mexico legalize medical cannabis through the state legislature?,4,2005,2002,2001,2007,4
,,,,2,Multiple Choice,Laws and Regulations,What state legalized medical cannabis through the state legislature in 2007?,4,Arizona,Idaho,New Mexico,Mississippi,3
,,,,2,Multiple Choice,Laws and Regulations,"In 2008, what state approved a ballot measure to decriminalize cannabis?",4,Massachusetts,New York,Maine,Michigan,1
,,,,2,Multiple Choice,Laws and Regulations,Massachusetts approved a ballot measure to decriminalize cannabis in what year?,4,2009,2008,2004,2001,2
,,,,2,Multiple Choice,Laws and Regulations,"In 2008, what state approved a ballot to legalize medical cannabis?",4,Massachusetts,New York,Maine,Michigan,4
,,,,2,Multiple Choice,Laws and Regulations,Michigan approved a ballot measure to legalize medical cannabis in what year?,4,2001,2008,2003,1992,2
,,,,2,Multiple Choice,Laws and Regulations,"In 2010, what state legalized medical cannabis through the state legislature?",4,New York,West Virginia,Florida,New Jersey,4
,,,,2,Multiple Choice,Laws and Regulations,New Jersey legalized medical cannais through the state legislature in what year?,4,2001,2010,2011,2005,2
,,,,2,Multiple Choice,Laws and Regulations,What state legalized medical cannabis through a ballot measure in 2010?,4,Arizona,New Mexico,New Jersey,Delaware,1
,,,,2,Multiple Choice,Laws and Regulations,Arizona legalized medical cannabis through a ballot measure in what year?,4,2001,2002,2010,2014,3
,,,,2,Multiple Choice,Laws and Regulations,"In 2010, what state legislators in what state reduced penalties for cannabis to a civil infraction?",4,Washington,Nevada,California,Oregon,3
,,,,2,Multiple Choice,Laws and Regulations,California state legislators reduced penalties for cannabis to a civil infraction in what year?,4,2010,2011,2002,2017,1
,,,,2,Multiple Choice,Laws and Regulations,"In 2011, what state legalized medical cannabis through state legislature?",4,Connecticut,Delaware,Rhode Island,Utah,2
,,,,2,Multiple Choice,Terpenoids and Cannabinoids,The a-Pinene terpene produces a pine aroma.,2,True,False,,,1
,,,,2,Multiple Choice,Terpenoids and Cannabinoids,The a-Pinene terpene produces a spicy aroma.,2,True,False,,,2
,,,,2,Multiple Choice,Terpenoids and Cannabinoids,The activation boiling point for the a-Pinene terpene is 311F,2,True,False,,,1
,,,,2,Multiple Choice,Terpenoids and Cannabinoids,The activation point for the a-Pinene terpene is 320F,2,True,False,,,2
,,,,2,Multiple Choice,Terpenoids and Cannabinoids,"Some of the potential effects of the a-Pinene terpene include alertness, memory retention, and it can also counteract some of the effects of THC.",2,True,False,,,1
,,,,2,Multiple Choice,Terpenoids and Cannabinoids,"Some of the potential effects of the a-Pinene terpene include alertness, memory retention, and it can also enhance some of the effects of THC.",2,True,False,,,2
,,,,2,Multiple Choice,Terpenoids and Cannabinoids,"The a-Pinene terpene can also be found in pine needles, rosemary, basil, parsley, and dill.",2,True,False,,,1
,,,,2,Multiple Choice,Terpenoids and Cannabinoids,"The a-Pinene terpene can also be found in mangos, basil, rosemary, lemongrass, and thyme.",2,True,False,,,2
,,,,2,Multiple Choice,Terpenoids and Cannabinoids,"The terpene a-Pinene is known to aid in the treatment of asthma, pain, inflammation, ulcers, anxiety, and cancer.",2,True,False,,,1
,,,,2,Multiple Choice,Terpenoids and Cannabinoids,"The terpene a-Pinene is known to aid in the treatment of asthma, pain, depression, anti-fungal, anxiety, and cancer.",2,True,False,,,2
,,,,2,Multiple Choice,Terpenoids and Cannabinoids,"The Myrcene terpene can smell a bit like cardamom, cloves, a bit musky, earthy, and herbal.",2,True,False,,,1
,,,,2,Multiple Choice,Terpenoids and Cannabinoids,"The Myrcene terpene produces a fruity, pine like scent.",2,True,False,,,2
,,,,2,Multiple Choice,Terpenoids and Cannabinoids,The activation boiling point for the Myrcene terpene is 332F.,2,True,False,,,1
,,,,2,Multiple Choice,Terpenoids and Cannabinoids,The activation boiling point for the Myrcene terpene is 254F.,2,True,False,,,2
,,,,2,Multiple Choice,Terpenoids and Cannabinoids,"A potential effect of the Myrcene terpene include a sedating ""couchlock"" effect.",2,True,False,,,1
,,,,2,Multiple Choice,Terpenoids and Cannabinoids,"A potential effect of the Myrcene terpene include an uplifting, euphoric effect that can aid in the treatment of depression.",2,True,False,,,2
,,,,2,Multiple Choice,Terpenoids and Cannabinoids,"The terpene Myrcene is known to aid in pain management, as well as treatment for insomnia and pain.",2,True,False,,,1
,,,,2,Multiple Choice,Terpenoids and Cannabinoids,"The terpene Myrcene is known to aid in the treatment of depression, eating disorders, and inflammation.",2,True,False,,,2
,,,,2,Multiple Choice,Terpenoids and Cannabinoids,"The Myrcene terpene can also be found in Mango, lemongrass, thyme, and hops.",2,True,False,,,1
,,,,2,Multiple Choice,Terpenoids and Cannabinoids,"The Myrcene terpene can also be found in Lavender, pine needles, thyme, and pepper.",2,True,False,,,2
,,,,2,Multiple Choice,Definitions,Endocannabinoid is defined as several chemical compounds that are naturally produced within the body and bind to the same brain receptors as compounds derived from cannabis.,2,True,False,,,1
,,,,2,Multiple Choice,Definitions,"Cannabinoid is defined as various naturally-occuring, biologically active, chemical consitutents of hemp or cannabis including some that possess psychoactive properties.",2,True,False,,,1
,,,,2,Multiple Choice,Lifestyle,"On April 5, 2018, Green Rush Daily Inc. acquired cannabis magazine High Times.",2,True,False,,,2
,,,,2,Multiple Choice,Politics,"Canadian cannabis advocates, Brian Taylor and Marc Emery, created the British Columbia Marijuana Party in 2001.",2,True,False,,,1
,,,,2,Multiple Choice,Methods of Consumption,Smoking hashish was a highly popular in the Middle East during the 12th Century.,2,True,False,,,1
,,,,2,Multiple Choice,Methods of Consumption,The oldest concentrate known to man is BHO.,2,True,False,,,2
,,,,2,Multiple Choice,Methods of Consumption,The two main methods of cannabis extraction are known as solvent-based extraction and non-solvent extraction.,2,True,False,,,1
,,,,2,Multiple Choice,Terpenoids and Cannabinoids,THCA is the acidic parent of the THC cannabinoid that is found in the raw cannabis plant.  What is THCA particularly useful for?,4,None of the Above,Appetite suppresant,Reducing cancerous cells,Creating a euphoric effect,1
,,,,2,Multiple Choice,Terpenoids and Cannabinoids,"CBDA is the acidic parent of CDB that is found in the raw cannabis plant, how is it converted to CBD?",4,When the flower is harvested off of the cannabis plant,"When it is left in a cool, damp, dark place",None of the above,When it is frozen,3
,,,,2,Multiple Choice,Terpenoids and Cannabinoids,"As harvest cannbis ages, THC will gradually be converted to what cannabionid?",4,None of the Above,CBG,THCV,CBD,1
,,,,2,Multiple Choice,Terpenoids and Cannabinoids,"What cannabinoid is useful as an antidepressant, a muscle relaxant, an antibiotic and antifungal agent, as well as a great blood pressure reducer?",4,CBC,THCV,THC,None of the above,4
,,,,2,Multiple Choice,Lifestyle,What year did Cannabis Culture Magazine cease it's printed publication to devote its resources to its online publication?,4,All of the above,2000,2009,2010,3
,,,,2,Multiple Choice,Celebrities in Cannabis,What country music star sits on the advisory board for the National Organization for the Reform of Marijuana Laws (NORML)?,4,Darius Rucker,Kelly Clarkson,Carrie Underwood,Willie Nelson,4
,,,,2,Multiple Choice,Celebrities in Cannabis,"With several movie and TV roles under his belt this actor/comedian not only has their own cannabis brand, but they also sit on the advisory board for the National Organization for the Reform of Marijuana Laws (NORML).",4,Cheech Marin,Seth Rogan,Tommy Chong,Joe Rogan,3
,,,,2,Multiple Choice,Celebrities in Cannabis,"A native Californian has toured with one of the most iconic rock bands in the world, is apart of the Rock & Roll Hall of Fame, Songwriters Hall of Fame, and is also on the advisory board for the National Organization for the Reform of Marijuana Laws (NORML).",4,Ozzy Osbourne,David Crosby,Phil Collins,Melissa Etheridge,2
,,,,2,Multiple Choice,Celebrities in Cannabis,This Emmy Award winning actor sits on the advisory board for The National Organization for the Reform of Marijuana Laws (NORML).,4,Woody Harrelson,Matthew Rhys,Henry Winkler,Don Cheadle,1
,,,,2,Multiple Choice,Methods of Consumption,Which of these solvents are used during the extraction process to separate the resin gland that contain THC from the cannabis flower?,3,Alcohol,Hydrogen Peroxide,Amonia,,1
,,,,2,Multiple Choice,Methods of Consumption,"What process of extraction uses water, temperature, and pressure to extract the resin glands containing THC from the cannabis flower?",2,Non-Solvent Extraction,Solvent Extraction,,,1
,,,,2,Multiple Choice,Cannabis Freedom Fighters,"Dana Larsen is one of the most well known Canadian cannabis advocates.  He served for 10 years as editor of Cannabis Culture Magazine, and was the co-founder of the Vancouver Seed Bank.",2,True,False,,,1
,,,,2,Multiple Choice,Methods of Consumption,"This concentrate is created by blasting fresh frozen plant material, creating amazing terpene and cannabinoid profiles that resemble the scent and flavor of the live plant.",4,Wax,Budder,All of the Above,Live Resin,4
,,,,2,Multiple Choice,Methods of Consumption,THC is metabolized from delta-9 THC into what chemical after it passes through the liver?,4,CBD,11-hydroxy THC,delta-8 hydroxy,THCA,2
,,,,2,Multiple Choice,Hemp and Hemp Products,Hemp requires minimal care and can grow in most climates.,2,True,False,,,1
,,,,2,Multiple Choice,Cannabis Economics,"The economic impact of legalizing cannabis is quite impressive, what state collected more than $135 million in taxes and fees from the sale of medical and recreational cannabis in 2015?",4,Washington,Oregon,California,Colorado,4
,,,,2,Multiple Choice,Growing Cannabis,"There are several different mediums for growing cannabis, which of the following describes growing cannabis without soil?",3,Hyrdoponic,Outdoor,Greenhouse,,1
,,,,2,Multiple Choice,Growing Cannabis,The Deep Water Culture hydroponic growing system is great for beginner cannabis growers.,2,True,False,,,1
,,,,2,Multiple Choice,Growing Cannabis,The Drip hydroponic growing system is the most widely known and used grow system in the world.,2,True,False,,,1
,,,,2,Multiple Choice,Science of Cannabis,Cannabis belongs to the Cannabaceae family.,2,True,False,,,1
,,,,2,Multiple Choice,Science of Cannabis,Which of the following is a small family of flowering plants that includes 170 different species including Cannabis?,4,Hemp,Indica,Cannabaceae,None of the Above,3
,,,,2,Multiple Choice,Growing Cannabis,Humidity is NOT an important factor in cannabis plant growth.,2,True,False,,,2
,,,,2,Multiple Choice,Growing Cannabis,"Germination is a process where the seeds sprout and the root emerges, with Cannabis it can take anywhere from 12 hours to 8 days.",2,True,False,,,1
,,,,2,Multiple Choice,Growing Cannabis,When the seed coat splits open to expose the root and cotyledons is called the seedling phase.,2,True,False,,,1
,,,,2,Multiple Choice,Growing Cannabis,How many weeks does a cannabis plant typically stay in the seedling phase?,4,2-6 weeks,2-3 weeks,None of the above,4-5 weeks,3
,,,,2,Multiple Choice,Growing Cannabis,"During the vegetative state of the cannabis plants growth cycle, it needs a significant amount of what depending on its genetics?",4,Light and Nutrients,Water and Light,Water and Darkness,Humidity and Nutrients,1
,,,,2,Multiple Choice,Growing Cannabis,"The pre-flowering phase is also referred to as the stretch, and it can take as little as one day or up to two weeks.",2,True,False,,,1
,,,,2,Multiple Choice,Growing Cannabis,The genetics of a strain one wants to grow can make a huge impact on how the plant grows.,2,True,False,,,1
,,,,2,Multiple Choice,Growing Cannabis,Genetics impact how a strain grows including which of the following?,4,All of the Above,How tall or short the plant tends to grow.,How quickly the plant grows.,How big the buds grow.,1
,,,,2,Multiple Choice,Growing Cannabis,Cannabis seeds that flower after the plant has reached a certain phase of development are called what?,4,Sativa,Autoflowering seeds,Photoperiod flowering plants,Standard Seeds,2
,,,,2,Multiple Choice,Growing Cannabis,Autoflowering cannabis strains tend to produce much smaller yields than cannabis grown the standard way.,2,True,False,,,1
,,,,2,Multiple Choice,Growing Cannabis,The benefits of autoflowering cannabis seeds are:,4,More resistant to cold and temperature changes,Can be grown year round as long as it doesn't become too cold,It is a reliable and timely crop every time,All the above,4
,,,,2,Multiple Choice,Cannabis Economics,"According to a November 2018 article by the Washington Post, the wholesale marijuana prices per pound have fallen by what percentage in Colorado since legalization in 2014? ",4,10%,30%,70%,50%,3
,,,,2,Multiple Choice,Lifestyle,The Hash Bash began in 1972 and is held every year on the first Saturday in April at noon in what U.S. university?,4,University of Oregon,University of Colorado Boulder,"University of California, Berkeley",University of Michigan,4
,,,,2,Multiple Choice,Celebrities in Cannabis,What famous comedian said: “Why is marijuana against the law? It grows naturally upon our planet. Doesn’t the idea of making nature against the law seem to you a bit . . . unnatural?” ,4,Bill Hicks,Rodney Dangerfield,Chris Rock,Mitch Hedberg,1
,,,,2,Multiple Choice,Strains,"If you have smoked a joint of ""Blue Dream"" for insomnia, then you have been affected by what type of terpene?",4,Limonene,Delta 3 Carene,Myrcene,Linalool,3
,,,,2,Multiple Choice,History,DMHP is a synthetic version of marijuana. When was it developed by the U.S. military?,4,1959,1949,1969,1979,2
,,,,2,Multiple Choice,History,"During the 1960's what U.S. university had the first experimental plot of marijuana grown on a designated site, using seeds from Mexico, Panama, Southeast Asia, Korea, India, Afghanistan, Iran, Pakistan and Lebanon? ",4,University of Florida,University of Oklahoma,University of Mississippi,Tulane University,3
,,,,2,Multiple Choice,Cannabis Economics,"What is the name of the first retail dispensary to open in Clark County, NV in 2015",4,Planet 13,Essence,Las Vegas ReLeaf,Euphoria Wellness,4
,,,,2,Multiple Choice,Lifestyle,"According to a 2018 article by The Princeton Review, what university has the highest student rating on marijuana use for 2017 and 2018?",4,University of Vermont,Yale,University of Colorado,Florida State University,1
,,,,2,Multiple Choice,Lifestyle,"In what year was ""High Times"" magazine founded by Tom Forçade?",4,1974,1954,1964,1984,1
,,,,2,Multiple Choice,Celebrities in Cannabis,"What 1998 movie starring Vince Vaughn, and Joaquin Phoenix is about a man sentenced to death for buying hash is Malaysia?",4,Clay Pigeons,Midnight Express,Leaves of Grass,Return to Paradise,4
,,,,2,Multiple Choice,Science of Cannabis,How long does it take the average person to pass a marijuana hair test if the sample is about 1.5 inches long? ,4,6 months,3 months,1 month,9 months,2
,,,,2,Multiple Choice,Hemp and Hemp Products,Who created the Hemp Car that ran on Hemp Ethanol?,4,Tommy Chong,Elon Musk,Henry Ford,Bill Gates,3
,,,,2,Multiple Choice,History,Which of these items was made from hemp?,4,The First American flag made by Betsy Ross,Superman's Cape for the Movies,A Sickle Blade,All of the Above,1
,,,,2,Multiple Choice,Laws and Regulations,"Of the 8.2 million marijuana arrests between 2001 and 2010, what percentage were for simply having marijuana.",4,88%,12%,43%,67%,1
,,,,2,Multiple Choice,Facts and Myths,"According to a new Marist poll that was conducted in partnership with Yahoo, what percentage of U.S. adults have smoked marijuana ?",4,12%,52%,32%,67%,2
,,,,2,Multiple Choice,Celebrities in Cannabis,"Who said, ""Some people are just better high""?",4,Miley Cyrus,Tim McGraw,Justin Timberlake,Taylor Swift,3
,,,,2,Multiple Choice,Celebrities in Cannabis,What is the name of Barack Obama's pot-smoking college group of friends?,4,The Choom Gang,Noobie Doobies,The Pot Head Alliance,Mary Jane's Brothers,1
,,,,2,Multiple Choice,Science of Cannabis,"When marijuana is smoked, from which organ is THC passed into the bloodstream?",4,Liver,Mouth,Kidneys,Lungs,4
,,,,2,Multiple Choice,History,"In October of 1937, Samuel Caldwell was the first U.S. citizen arrested under the Marijuana Tax Act for selling marijuana without paying the newly mandated tax. What was his punishment?",4,Life in prison.,"$20,000 fine","Fined $1,000 and sentenced to four years of hard labor in Leavenworth.",Death,3
,,,,2,Multiple Choice,Celebrities in Cannabis,"This 2018 documentary on Netflix was about the big business of marijuana and the history of growing it in Humboldt County, California. Name the documentary.",4,Murder Mountain,On the Hill,Mary Jane Mountain,Hemp Hill,1
,,,,2,Multiple Choice,Laws and Regulations,Blacks are how many times more likely than whites to be arrested for marijuana.,4,1.73,5.73,3.73,10.73,3
,,,,2,Multiple Choice,Celebrities in Cannabis,Whose birthday is on 4/20?,4,All of the Above,Adolf Hitler,Jessica Lange,Carmen Electra,1
,,,,2,Multiple Choice,Laws and Regulations,What legal classification is marijuana?,4,Schedule I,Schedule II,Schedule III,Schedule IV,1
,,,,2,Multiple Choice,Definitions,Cannabis has male and female plants; what is this called?,3,Meaning: (of a plant or invertebrate animal) having the male and female reproductive organs in separate individuals.,Dioecious,Origin is English and Greek to Modern Latin.,,2
,,,,2,Multiple Choice,Growing Cannabis,"According to a January 2018 article by Civilized., what African countries produces the most weed in Africa?",4,Nigeria,Morocco,Ethiopia,Kenya,2
,,,,1,Multiple Choice,Hemp and Hemp Products,Which one one these is NOT a brand of marijuana products?,4,BNP Paribas,BNP Paribas,Marley Natural,The Goodship Company,2
,,,,1,Multiple Choice,Lifestyle,"The High Times Cannabis Cup, beginning in 1988 and typically taking place in San Bernardino, CA, technically started out as a cannabis festival in what European city?",4,Berlin,Vienna,Amsterdam,Stockholm,3
,,,,1,Multiple Choice,Politics,All of these are Cannabis rights organizations except for:,4,Al Anon,Alliance for Cannabis Therapeutics,Americans for Safe Access,Dagga Couple,1
,,,,1,Multiple Choice,Strains,What is Granddaddy Purple?,3,Sativa,Hybrid,Indica,,3
,,,,1,Multiple Choice,Celebrities in Cannabis,Which item was Bob Marley NOT buried with?,4,His Bible,His Guitar,A Bud of Marijuana,His Crucifix,4
,,,,1,Multiple Choice,Laws and Regulations,"In 1996, what U.S. state was the first to legalize medical cannabis?",4,Maine,California,Colorado,Oregon,2
,,,,1,Multiple Choice,Celebrities in Cannabis,This 2008 film starring James Franco and Seth Rogan is about a process server and his marijuana dealer as they are forced to flee from hitmen and a corrupt police officer after witnessing them commit a murder. ,4,Pineapple Express,Grandma's Boy,How High,Half Baked,1
,,,,1,Multiple Choice,Paraphernalia,What is the name of a filtered water pipe used to smoke marijuana?,4,Hash Pipe,Bradley,Water Flow,Bong,4
,,,,1,Multiple Choice,Science of Cannabis,What is the main psychoactive compound in marijuana?,4,Delta9-Tetrahydrocannabinol (THC),Cannabidiol (CBD),Myrcene,Linalool,1
,,,,1,Multiple Choice,Celebrities in Cannabis,"Who sang the 2001 song, ""Because I Got High""?",4,Snoop Dogg,G-Eazy,Afroman,Lil' Wayne,3
,,,,1,Multiple Choice,Science of Cannabis,Which one of the following is NOT an effect of smoking marijuana?,4,Changes in memory,Difficulty with hearing,Changes in mood,Changes in appetite,2
,,,,1,Multiple Choice,Facts and Myths,An Indian milkshake whose main ingredient is marijuana.,4,Tiger's Blood,Bhang,Murg Makhani,Rogan Josh,2
,,,,1,Multiple Choice,History,Cannabis seeds were used as a food source in what country as early as 6000 B.C.?,4,India,Japan,Russia,China,4
,,,,1,Multiple Choice,Celebrities in Cannabis,"Who said, ""Never smoke pot before there's the possibility of having to talk to a hundred million people,""  when speaking about accepting an Oscar at the the 1991 Academy Awards?",4,Kevin Costner,Whoopi Goldberg,Jeremy Irons,Joe Pesci,2
,,,,1,Multiple Choice,Celebrities in Cannabis,"Which of these artists have songs with, ""Mary Jane"" in the title?",4,All of the Above,Creeence Clearwater Revival,Rick James,Run D.M.C.,3
,,,,1,Multiple Choice,Legal Cannabis Worldwide,"In 2003, what country became the first country in Noth America to offer medical marijuana to pain-suffering patients?",4,Canada,Mexico,United States of America,Greenland,1
,,,,1,Multiple Choice,Laws and Regulations," The Compassionate Use Act of 1996, is a California law allowing the use of medical cannabis that was put on the ballot as...",3,Proposition 415,Proposition 215,Proposition 400,,2
,,,,1,Multiple Choice,Celebrities in Cannabis,"After his murder, members of who's music group mixed his ashes with marijuana and smoked the concoction?",4,Notorious B.I.G.,Soulja Slim,Tupac Shakur,Nipsey Hussle,3
,,,,1,Multiple Choice,Facts and Myths,What were the names of the vending machines in Seattle that dispensed marijuana flower buds in medical marijuana dispensaries? ,4,ZaZZZ,Green Machine,GaGGS,The Grinch,1
,,,,1,Multiple Choice,Cannabis Economics,Data analytics firm BDS Analytics calculated that how many people were employed by the U.S. cannabis industry in 2017.,4,"121,000","21,000","51,000","75,000",1
,,,,1,Multiple Choice,Facts and Myths,Marijuana has been used to fight opioid addiction due to the overdose ratio. Approximately how many opioid deaths by overdose were recorded in 2017?,4,"90,003","15,876","70,237","52,504",3
,,,,1,Multiple Choice,Cannabis Economics,Which one of the following is NOT a marijuana company stock listed on NASDAQ?,4,Village Farms International,Intec Pharma Ltd.,Cronos Group Inc.,Pepperidge Farms Ltd.,4
,,,,1,Multiple Choice,Facts and Myths,"According to an August 2017 survey from the independent Quinnipiac University, what percentage of Americans supported the legalization of medical marijuana?",4,12%,76%,94%,32%,3
,,,,1,Multiple Choice,Definitions,Which of the following is another term for marijuana?,4,Mary Jane,Reefer,All of the Above,Dope,3
,,,,1,Multiple Choice,Celebrities in Cannabis,"What 1998 movie starred Dave Chappelle, Jim Breuer and Harland Williams and is about a stoner in jail for accidentally killing a diabetic police horse. ",4,Grandma's Boy,Half Baked,Kid Cannabis,Smiley Face,2
,,,,1,Multiple Choice,History,The first online purchase of marijuana was between students from what 2 colleges?,4,Stanford and MIT,Duke and University of North Carolina at Chapel Hill,"University of California, Berkeley and Harvard",Yale and Princeton,1
,,,,1,Multiple Choice,Science of Cannabis,How long after smoking marijuana are mental and physical abilities weakened?,4,About 10 hours,About an hour,About 24 hours,About 4 or 5 hours,3
,,,,1,Multiple Choice,Science of Cannabis,What is amotivational syndrome?,4,Loss of interest in goals and life outside of marijuana use.,Increased aggression with marijuana use.,Increased manic depression due to little marijuana use.,A hereditary bowel disease caused by marijuana.,1
,,,,1,Multiple Choice,Facts and Myths,What is the most commonly used illicit drug in the United States.,4,Cocaine,Marijuana,Valium,Percocet,2
,,,,1,Multiple Choice,Celebrities in Cannabis,"What high school classmate was Snoop Dogg referring to when he told George Lopez, ""I might have sold her some of that white girl weed""?",4,Cameron Diaz,Lindsay Lohan,Drew Barrymore,Jennifer Garner,4
,,,,1,Multiple Choice,Science of Cannabis,"What is the proper, biological name of marijuana?",4,Cannabis Erotica,Cannabis Tetris,Cannabis Sativa,Cannabis Erronis,3
,,,,1,Multiple Choice,Celebrities in Cannabis,"What television series is about a single-mother named Nancy whose husband died, so she starts to sell her own strain of marijuana called ""MILF""",4,High Maintenence,Weeds,Bong Appétit,Mary+Jane,2
,,,,1,Multiple Choice,Celebrities in Cannabis,"Who said, ""When I was in England, ""I experimented with marijuana a time or two, and didn't like it. I didn't inhale and I didn't try it again.""",4,Bill Clinton,Tiger Woods,Richard Nixon,Serena Williams,1
,,,,1,Multiple Choice,Celebrities in Cannabis,Marijuana prohibition is just the stupidest law possible… Just legalize it and tax it like we do liquor.,4,John F. Kennedy,Bob Hope,Sylvester Stallone,Morgan Freeman,4
,,,,1,Multiple Choice,Celebrities in Cannabis,"Who said, ""That is not a drug, it’s a leaf.""",4,Arnold Schwarzenegger,Taylor Swift,Brad Pitt,Jeff Sessions,1
,,,,1,Multiple Choice,Celebrities in Cannabis,"Who said, ""I used to smoke marijuana. But I’ll tell you something: I would only smoke it in the late evening. Oh, occasionally the early evening, but usually the late evening – or the mid-evening. Just the early evening, mid-evening and late evening. Occasionally, early afternoon, early midafternoon, or perhaps the late-mid-afternoon. Oh, sometimes the early-mid-late-early morning… But never at dusk.""",4,John Belushi,Kim Carnes,Steve Martin,Michael Jordan,3
,,,,1,Multiple Choice,Science of Cannabis,What is NOT a subspecies of cannabis,4,Sativa,Aurorealis,Indica,Ruderalis,2
,,,,1,Multiple Choice,Facts and Myths,Jamestown was a colony Virginia. In what year did a colony law declare that all settlers must grow Indian hemp?,4,1619,1519,1719,1789,1
,,,,1,Multiple Choice,Facts and Myths,How many marijuana related deaths are there every year in the United States on average?,4,"It is hard to tell due to the fact that it is actually used by drinkers, cigarette smokers and opioid users, so a true number cannot be furnished yet.","10,000","20,000","30,000",1
,,,,1,Multiple Choice,Laws and Regulations,How many people are in U.S. prisons for non-violent marijuana-related offenses?,4,1.3 million,"About 240,000","About 40,000","About 500,000",3
,,,,1,Multiple Choice,Laws and Regulations,What are the maximum U.S. federal sentencing guidelines for a first-time offense of possession of any amount of marijuana?,4,5 years in prison and $5000 in fines,30 days in jail,"1 year in prison and $1,000 in fines",6 months in prison and $500 in fines,3
,,,,1,Multiple Choice,Methods of Consumption,What is the safest way to use marijuana?,4,Vaporizer,Eat it,Smoke it as a joint,In a bong with ice cold water,2
,,,,1,Multiple Choice,Legal Cannabis Worldwide,Is it Legal to Use/Possess Marijuana in Jamaica for recreational purposes?,3,"No, it is not legal.","Yes, it is legal.",It is only legal in some parts of the country.,,1
,,,,1,Multiple Choice,Laws and Regulations,Are religious uses of cannabis permitted in the United States?,3,Yes,No,"Yes, but only to Rastafarias",,2
,,,,1,Multiple Choice,Science of Cannabis,Which one of these effects is NOT a symptom of marijuana?,4,Delusions,Psychosis,The Bends,Altered Sense of Time,3
,,,,1,Multiple Choice,Facts and Myths,What percentage of American 12th graders use marijuana daily?,3,1.8%,2.8%,5.80%,,3
,,,,1,Multiple Choice,Celebrities in Cannabis,"Who said, ""I smoked some weed and that's how I finished Izzo""?",4,P-Diddy,Jay-Z,Eminem,Cardi-B,2
,,,,1,Multiple Choice,Science of Cannabis,Recent data suggest that what percent of those who use marijuana may have some degree of marijuana use disorder.,3,25%,30%,10%,,2
,,,,1,Multiple Choice,Facts and Myths,The Insurance Institute for Highway Safety analyzed insurance claims for vehicle collisions filed between January 2012 and October 2016. They found the states that had recently legalized marijuana had what percentage of higher collision claims then the states that were illegal?,4,3%,5%,10%,15%,1
,,,,1,Multiple Choice,Science of Cannabis,You should be able to determine the _____ on your plant between four and six weeks by looking at the pre-flowers.,4,Color,Height,Price,Sex,4
,,,,2,Multiple Choice,Definitions,Ganja comes from the swahili word for hemp.,2,True,False,,,2
,,,,2,Multiple Choice,History,U.S. President Harry Truman signed the Marijuana Tax Act of 1937 that placed the first tax on the sale of cannabis.  ,2,True,False,,,2
,,,,2,Multiple Choice,Politics,"Justin Trudeau, who became the Canadian Prime Minister in 2015, made marijuana legalization in Canada a key part of his campaign. ",2,True,False,,,1
,,,,2,Multiple Choice,Cannabis Economics,"When you buy an eight of weed at a dispensary, it is 7 grams.",2,True,False,,,2
,,,,2,Multiple Choice,Definitions,"The term ""420"" came about because marijuana was said to be smoked the most on April 20th because it was an ""Earthly Day"".",2,True,False,,,2
,,,,2,Multiple Choice,Science of Cannabis,"A humulus plant is related to cannabis and is known as a ""Cannabaceae"".",2,True,False,,,1
,,,,2,Multiple Choice,Definitions,"""420"" is celebrated on April 20th for smoking marijuana. ""720"" is celebrated on July 10th and celebrated the dabs and cannabis concentrates on this day. ",2,True,False,,,1
,,,,2,Multiple Choice,Science of Cannabis,Marijuana deposits about 5 times as musch tar in the lungs than tobacco smoking does.,2,True,False,,,1
,,,,2,Multiple Choice,Facts and Myths,"In 2011, an article was published that a U.S. marshal sweeps through the greenhouses in Antarctica so no one grows weed there.",2,True,False,,,1
,,,,2,Multiple Choice,Science of Cannabis,It takes 10 seconds for marijuana to reach peak levels in the brain.,2,True,False,,,2
,,,,2,Multiple Choice,History,"In 1958, future U.S. President, Richard Nixon, saw his friend, Dean Martin, in line for customs at Idlewild Airport in New York. He grabbed his bags and walked him through. However, there was 3 pounds of marijuana in his suitcase. Richard Nixon ""Muled"" 3 pounds of marijuana for Dean Martin.",2,True,False,,,2
,,,,2,Multiple Choice,Facts and Myths," Due to legalization, the number of young people who believe regular marijuana use is risky is decreasing.",2,True,False,,,1
,,,,2,Multiple Choice,Science of Cannabis,It possible to overdose on marijuana.,2,True,False,,,1
,,,,2,Multiple Choice,Science of Cannabis,Most people harvest their marijuana plants when the trichomes are mostly milky-white from clear with a pronounced amber in some of the crystals.,2,True,False,,,1
,,,,2,Multiple Choice,Facts and Myths,A study from New Zealand conducted in part by researchers at Duke University showed that people who started smoking marijuana heavily in their teens and had an ongoing marijuana use disorder lost an average of 8 IQ points between ages 13 and 38.,2,True,False,,,1
,,,,2,Multiple Choice,Hemp and Hemp Products,"The ropes, sails, and caulking of the Mayflower were all made from hemp fiber.",2,True,False,,,1
,,,,2,Multiple Choice,Science of Cannabis,Cannabis and beer are related.,2,True,False,,,2
,,,,2,Multiple Choice,Facts and Myths,"Spiders high on marijuana spun highly geometric webs, even more so than when they were sober. Spiders high on LSD, on the other hand, built messy webs, were easily distracted, and gave up easily. ",2,True,False,,,2
,,,,1,Multiple Choice,Legal Cannabis Worldwide,Marijuana is legalized in the U.S. state of Maine.,2,True,False,,,1
,,,,1,Multiple Choice,Hemp and Hemp Products,Hemp is a variety of the cannabis indica strain.,2,True,False,,,2
,,,,1,Multiple Choice,Politics,The Green Panthers is a cannabis rights organization.,2,True,False,,,1
,,,,1,Multiple Choice,Methods of Consumption,"With marijuana, concentrates are more potent than smoking.",2,True,False,,,1
,,,,1,Multiple Choice,Science of Cannabis,Cannabis flowers can be either male or female.,2,True,False,,,1
,,,,1,Multiple Choice,Cannabis Economics,"There are more marijuana dispensaries in Denver, CO than Starbucks.",2,True,False,,,1
,,,,1,Multiple Choice,Legal Cannabis Worldwide,Recreational marijuana use is legal in Canada.,2,True,False,,,1
,,,,1,Multiple Choice,Celebrities in Cannabis,"Willie Nelson, the 86 year-old singer, smokes marijuana every single day.",2,True,False,,,1
,,,,1,Multiple Choice,Cannabis Economics,"In Nevada, as of January 2017, adults over the age 21 can legally possess and purchase up to an ounce of marijuana flower and an eighth of marijuana concentrate at a time, for recreational use.",2,True,False,,,1
,,,,1,Multiple Choice,Politics,Alabama U.S. Senator Jeff Sessions smokes marijuana.,2,True,False,,,2
,,,,1,Multiple Choice,Science of Cannabis,K2/Spice is a cannabis product that is composed of purified resin glands.,2,True,False,,,2
,,,,1,Multiple Choice,Medical Benefits,Marijuana decreases your appetite.,2,True,False,,,2
,,,,1,Multiple Choice,Laws and Regulations,The California Decriminalization Bill of 1973 abolished criminal penalties for possession of small amounts of marijuana.,2,True,False,,,2
,,,,1,Multiple Choice,Laws and Regulations,"It is illegal for anyone under the age of 21 to buy, possess, or use retail marijuana in Nevada.",2,True,False,,,1
,,,,1,Multiple Choice,History,U.S. President Donald Trump grows marijuana.,2,True,False,,,2
,,,,1,Multiple Choice,Facts and Myths,The first thing ever sold online was a bong.,2,True,False,,,2
,,,,1,Multiple Choice,Cannabis Economics,"In 2018, Paraguay legalized marijuana for recreational used.",2,True,False,,,2
,,,,1,Multiple Choice,Science of Cannabis,What is the name of cannabis that has less than 1% of THC?,2,True,False,,,1
,,,,1,Multiple Choice,History,Former U.S. President James Monroe openly smoked hashish when he served as ambassador to France,2,True,False,,,1
,,,,1,Multiple Choice,Science of Cannabis,Marijuana smoke contains carcinogenic combustion products.,2,True,False,,,1
,,,,1,Multiple Choice,Science of Cannabis,Cannabis is a complex plant with over 400 chemical entities.,2,True,False,,,1
,,,,1,Multiple Choice,Hemp and Hemp Products,Large amounts of hemp seed or oil can act as a laxative and cause diarrhea.,2,True,False,,,1
,,,,1,Multiple Choice,Definitions,"In Hawaii, marijuana is called, ""Pakalolo"".",2,True,False,,,1
,,,,1,Multiple Choice,Facts and Myths,"According to one national survey on drug use, each day approximately 6,000 Americans try marijuana for the first time.",2,True,False,,,1
,,,,1,Multiple Choice,Facts and Myths,The amount of THC in marijuana has been increasing steadily over the past few decades.,2,True,False,,,1
,,,,1,Multiple Choice,Facts and Myths,"The popularity of edibles also increases the chance of harmful reactions. Edibles take longer to digest and produce a high. Therefore, people may consume more to feel the effects faster, leading to dangerous results.",2,True,False,,,1
,,,,1,Multiple Choice,Science of Cannabis,Chlorophyll is what makes marijuana purple.,2,True,False,,,2
,,,,1,Multiple Choice,Science of Cannabis,"About 24 hours after smoking marijuana, mental and physical abilities weakened.",2,True,False,,,1
,,,,1,Multiple Choice,Facts and Myths,"In 2010, a mine collapsed in the country of Chile and the miners were trapped for 69 days. True or False, pornograpghy and marijuana were supplied to them to calm them down.",2,True,False,,,1
,,,,1,Multiple Choice,Facts and Myths,Women are over twice as likely as men to use marijuana in the U.S.,2,True,False,,,2
,,,,1,Multiple Choice,Paraphernalia,The bowl of a pipe or a bong is where your mouth goes.,2,True,False,,,2
,,,,1,Multiple Choice,Science of Cannabis,Higher THC levels may also means less of a risk for addiction if people are regularly exposing themselves to high doses.,2,True,False,,,2
,,,,1,Multiple Choice,Science of Cannabis,Marijuana is not additive.,2,True,False,,,2
,,,,2,Multiple Choice,Terpenoids and Cannabinoids,Which terpenoid helps to increase energy and mental focus?,4,Pinene,Limonene,Linalool,Myrcene,1
,,,,2,Multiple Choice,Terpenoids and Cannabinoids,Which terpenoid helps to reduce pain and anxiety?,4,Myrcene,Pinene,Linalool,Limonene,4
,,,,2,Multiple Choice,Terpenoids and Cannabinoids,Which terpenoid produces calming effects?,4,Myrcene,Pinene,Linalool,Limonene,3
,,,,2,Multiple Choice,Terpenoids and Cannabinoids,Which terpenoid contains anti-depressant and anti-inflammatory properties?,4,Pinene,Myrcene,Limonene,Linalool,2
,,,,2,Multiple Choice,Celebrities in Cannabis,"A popular Sativa-dominant strain combined with a Haze Hybrid, Northern Light #5 and Shiva Skunk cross was named after which celebrity?",4,Obama Kush,Chuck Norris Black and Blue Dream,Snoop Dogg OG,Jack Herer,4
,,,,2,Multiple Choice,Methods of Consumption,It is best to recommend _______ as an appropriate method of consumption to someone who wants to avoid smoking cannabis,3,Ingestion,Topical,Inhalation,,3
,,,,2,Multiple Choice,Methods of Consumption,Which statement is true for Oral Ingestion?,2,Oral ingestion offers consumers a method of consumption that does not require the use of lungs,Oral Ingestion offers consumers a method of consumption that requires the use of lungs,,,1
,,,,1,Multiple Choice,Strains,Which is true for Indica cannabis strains?,3,"Indica strains tend to be more sedating and relaxing, with full-body effects",Indica strains deliver an energizing effect,Indica strains are most appropriate for day time use,,1
,,,,1,Multiple Choice,Strains,Which is true for Sativa cannabis strains?,3,Sativa strains are appropriate for evening or night time use,"Sativa strains tend to be more sedating and relaxing, with full-body effects",Sativa strains deliver an energizing effect and are most appropriate for day time use,,3
,,,,1,Multiple Choice,Strains,________ strains deliver energizing effects and are most appropriate for day time use,2,Sativa,Indica,,,1
,,,,1,Multiple Choice,Strains,"________ strains tend to be more sedating and relaxing, with full-body effects, and are appropriate for night time use",2,Sativa,Indica,,,2
,,,,1,Multiple Choice,Strains,Which strain is generally used to relieve pain and insomnia?,2,Sativa,Indica,,,2
,,,,1,Multiple Choice,Strains,Which strain is generally used to relieve depression and fatigue?,2,Indica,Sativa,,,1
,,,,1,Multiple Choice,Celebrities in Cannabis,Which celebrity cannabis advocate released the cookbook ‘From Crook to Cook’ in October of 2018?,4,Wiz Khalifa,Snoop Dogg,Tommy Chong,Martha Stewart,2
,,,,1,Multiple Choice,Celebrities in Cannabis,Which celebrity cannabis advocate co-hosts Potluck Dinner Party show with Snoop Dogg ?,4,Guy Fieri,Rachel Ray,Martha Stewart,Gordon Ramsey,3
,,,,1,Multiple Choice,Celebrities in Cannabis,Which celebrity was spotted smoking marijuana while on vacation in Hawaii in 2012?,4,Rihanna,Tommy Chong,Miley Cyrus,Wiz Khalifa,1
,,,,1,Multiple Choice,Celebrities in Cannabis,Which U.S. President's name was used for a popular Indica strain?,4,Barack Obama,George W Bush,Bill Clinton,Richard Nixon,1
,,,,1,Multiple Choice,Celebrities in Cannabis,Which celebrity duo is best known for their comedy and bringing recreational marijuana use to the mainstream?,4,Will Smith & Martin Lawrence,Cheech Marin & Tommy Chong,Method Man & Redman,Jay & Silent Bob,2
,,,,1,Multiple Choice,Methods of Consumption,Which inhalation method is best used in effort to avoid inhalaing irritants and potential carcinogens?,4,Combustion (Smoking),Edibles,Vaporization,Sublinguals,3
,,,,1,Multiple Choice,Laws and Regulations,Which statement is true for public consumption?,4,"It is strictly prohibited to smoke, vaporize or otherwise consume cannabis in public places","It is strictly prohibited to smoke cannabis in public places, however vaporization and edible consumption is permitted.",,,1
,,,,1,Multiple Choice,Laws and Regulations,Which is true for customer confidentiality?,4,All personal information collected is confidential and private,"Personal information will be released to any third party, excluding the customer or patient's written consent","Personal information will be released to any third party, excluding customer or patient's written consent",All personal information collected is not considered confidential or private,1
,,,,2,Multiple Choice,Laws and Regulations,"In the state of Nevada, patient records should be maintained for at least...",4,6 months to 1 year,5 years,3 years,10 years,2
,,,,2,Multiple Choice,Laws and Regulations,"In the state of Nevada, all dispensary employees are required to have:",3,A medical marijuana recommendation,A medical marijuana certification,An agent card,,3
,,,,2,Multiple Choice,Laws and Regulations,"In the state of Nevada, the legal purchase amount for Medical Marijuana Patient is:",3,"1 ounce of marijuana or up to 1/8th of an ounce of concentrated marijuana not to exceed 1,750 mg of THC",2.5 ounces of usable marijuana,1/8th of an ounce of marijuana,,1
,,,,2,Multiple Choice,Laws and Regulations,"In the state of Nevada, the legal possession amount for Medical Marijuana Patients is:",3,2.5 ounces of useable marijuana,1/8th of an ounce of marijuana,"1 ounce of marijuana or up to 1/8th of an ounce of concentrated marijuana not to exceed 1,750 mg of THC",,1
,,,,2,Multiple Choice,Laws and Regulations,Delaware legalized medical cannabis through the state legislature in what year?,4,2011,2010,2017,2000,1
,,,,2,Multiple Choice,Laws and Regulations,"In 2011, what state decriminalized cannabis through the state legislature?",4,New York,"Washington, D.C.",Connecticut,Delaware,3
,,,,2,Multiple Choice,Laws and Regulations,Connecticut decriminalized cannabis through the state legislature in what year?,4,2010,2011,2012,2004,2
,,,,2,Multiple Choice,Laws and Regulations,"In 2012, what state legalized medical cannabis through the state legislature?",4,Nevada,Delaware,Connecticut,Idaho,3
,,,,2,Multiple Choice,Laws and Regulations,Connecticut legalized medical cannabis through the state legislature in what year?,4,2011,2002,2015,2012,4
,,,,2,Multiple Choice,Laws and Regulations,Amendment 64 was a measure outlining a statewide drug policy for cannabis to amend the Constitution of what state?,4,Washington,California,Nebraska,Colorado,4
,,,,2,Multiple Choice,Laws and Regulations,Colorado's measure outlining a statewide drug policy for cannabis to amend the Colorado State Constitution was labeled what?,4,Initiative 502,Amendment 420,Amendment 64,Act 710,3
,,,,2,Multiple Choice,Laws and Regulations,Initiative 502 (I-502) was an initiative to legalize small amounts of marijuana-related products for adults 21 years or older for individuals in what state?,4,Washington,Colorado,California,Nebraska,1
,,,,2,Multiple Choice,Laws and Regulations,Washington Initiative 502 (I-502) was an initiative to the Washington State Legislature that was passed in what year?,4,2012,2011,2010,2005,1
,,,,2,Multiple Choice,Laws and Regulations,"In 2012, two states became the first in the United States to legalize the recreational use of cannabis, what states were they?",4,Colorado and Nevada,California and Washington,New York and Florida,Colorado and Washington,4
,,,,2,Multiple Choice,Laws and Regulations,"Colorado and Washington became the first states in the US to legalize the recreational use of cannabis, what year did this happen?",4,2013,2010,2012,2006,3
,,,,2,Multiple Choice,Laws and Regulations,"In 2013, what state decriminalized cannabis through the state legislature?",4,New York,Utah,Nevada,Vermont,4
,,,,2,Multiple Choice,Laws and Regulations,Vermont decriminalized cannabis in what year?,4,2012,2013,2014,2016,2
,,,,2,Multiple Choice,Laws and Regulations,New Hampshire legalied medical cannabis through the state legislature in what year?,4,2012,2013,2005,2016,2
,,,,2,Multiple Choice,Laws and Regulations,In what year did Illinois legalize medical cannabis through the state legislature?,4,2014,2012,2013,2010,3
,,,,2,Multiple Choice,Laws and Regulations,Delaware legalized medical cannabis through the state legislature in what year?,4,2010,2017,2011,2000,3
,,,,2,Multiple Choice,Laws and Regulations,"In 2011, what state decriminalized cannabis through the state legislature?",4,Connecticut,Delaware,New York,"Washington, D.C.",1
,,,,2,Multiple Choice,Laws and Regulations,Connecticut decriminalized cannabis through the state legislature in what year?,4,2010,2012,2004,2011,4
,,,,2,Multiple Choice,Laws and Regulations,"In 2012, what state legalized medical cannabis through the state legislature?",4,Nevada,Delaware,Connecticut,Idaho,3
,,,,2,Multiple Choice,Laws and Regulations,Connecticut legalized medical cannabis through the state legislature in what year?,4,2011,2012,2002,2015,2
,,,,2,Multiple Choice,Laws and Regulations,Amendment 64 was a measure outlining a statewide drug policy for cannabis to amend the Constitution of what state?,4,Colorado,Washington,California,Nebraska,1
,,,,2,Multiple Choice,Laws and Regulations,Colorado's measure outlining a statewide drug policy for cannabis to amend the Colorado State Constitution was labeled what?,4,Amendment 64,Initiative 502,Amendment 420,Act 710,1
,,,,2,Multiple Choice,Laws and Regulations,Initiative 502 (I-502) was an initiative to legalize small amounts of marijuana-related products for adults 21 years or older for individuals in what state?,4,California,Colorado,Washington,Nebraska,3
,,,,2,Multiple Choice,Laws and Regulations,Washington Initiative 502 (I-502) was an initiative to the Washington State Legislature that was passed in what year?,4,2011,2010,2012,2005,3
,,,,2,Multiple Choice,Laws and Regulations,"In 2012, two states became the first in the United States to legalize the recreational use of cannabis, what states were they?",4,Colorado and Washington,Colorado and Nevada,California and Washington,New York and Florida,1
,,,,2,Multiple Choice,Laws and Regulations,"Colorado and Washington became the first states in the US to legalize the recreational use of cannabis, what year did this happen?",4,2013,2010,2012,2006,3
,,,,2,Multiple Choice,Laws and Regulations,"In 2013, what state decriminalized cannabis through the state legislature?",4,New York,Vermont,Utah,Nevada,2
,,,,2,Multiple Choice,Laws and Regulations,Vermont decriminalized cannabis in what year?,4,2012,2014,2016,2013,4
,,,,2,Multiple Choice,Laws and Regulations,New Hampshire legalied medical cannabis through the state legislature in what year?,4,2012,2005,2013,2016,3
,,,,2,Multiple Choice,Laws and Regulations,In what year did Illinois legalize medical cannabis through the state legislature?,4,2014,2013,2012,2010,2
,,,,2,Multiple Choice,Laws and Regulations,"In 2013, two states legalized medical cannabis through the state legislature, what states were they?",4,Illinois and New Hampshire,Indiana and New York,New Hampshire and Nevada,Alaska and Illinois,1
,,,,2,Multiple Choice,Laws and Regulations,"What state became the first in the nation to pass a low-THC, high-CBD medical cannabis law?",4,Utah,Nevada,Idaho,Montana,1
,,,,2,Multiple Choice,Laws and Regulations,"Expanding on the limited measure passed in 2003, what states legislators decriminalized cannabis and approved a comprehensive medical cannabis law?",4,Utah,Maryland,Nevada,California,2
,,,,2,Multiple Choice,Laws and Regulations,"In 2014, what state decriminalized cannabis through the state legislature?",4,Mississippi,Minnesota,Missouri,Colorado,2
,,,,2,Multiple Choice,Laws and Regulations,Missouri decriminalized cannabis through the state legislature in what year?,4,2015,2014,2010,2012,2
,,,,2,Multiple Choice,Laws and Regulations,"In 2014, what two states legalized medical cannabis through their states legislatures?",4,Minnesota and New York,New York and New Jersey,Vermont and Colorado,Nevada and Nebraska,1
,,,,2,Multiple Choice,Laws and Regulations,Minnesota and New York legalized medical cannabis through their state legislatures in what year?,4,2010,2011,2014,2012,3
,,,,2,Multiple Choice,Laws and Regulations,New York state legalized medical cannabis through the state legislature in what year?,4,2015,2010,2012,2014,4
,,,,2,Multiple Choice,Laws and Regulations,Minnesota legalized medical cannabis through the state legislature in what year?,4,2015,2010,2012,2014,4
,,,,2,Multiple Choice,Laws and Regulations,"In 2014, what two states legalized the use of recreational cannabis through a ballot measure?",4,Alaska and Oregon,Oregon and Washington,Nevada and California,Arizona and Alaska,1
,,,,2,Multiple Choice,Laws and Regulations,Alaska legalized the use of recreational cannabis through a ballot measure in what year?,4,2001,2014,2012,2010,2
,,,,2,Multiple Choice,Laws and Regulations,Oregon legalized the use of recreational cannabis through a ballot measure in what year?,4,2002,2017,2010,2014,4
,,,,2,Multiple Choice,Laws and Regulations,In what year did Delaware decriminalize cannabis through the state legislature?,4,2012,2015,2005,2011,2
,,,,2,Multiple Choice,Laws and Regulations,What state decriminilized cannabis through the state legislature in 2015?,4,Delaware,Alaska,Oregon,Utah,1
,,,,2,Multiple Choice,Laws and Regulations,In what year did Louisiana legsilators pass a limited medical cannabis law?,4,2012,2011,2015,2013,3
,,,,2,Multiple Choice,Laws and Regulations,"In 2015, what states legsilators passed a limited medical cannabis law?",4,Louisiana,Arkansas,Mississippi,Texas,1
,,,,2,Multiple Choice,Laws and Regulations,In what year did Pennsylvania legalize medical cannabis through the state legislature?,4,2015,2011,2016,2010,3
,,,,2,Multiple Choice,Laws and Regulations, In what year did Ohio legalize the medical use of cannabis through the state legislature?,4,2015,2016,2011,2010,2
,,,,2,Multiple Choice,Laws and Regulations,What two states legalized the medical use of cannabis through the state legsilature in 2016?,4,Pennsylvania and Ohio,Ohio and Indiana,Illinois and Indiana,Kentucky and Ohio,1
,,,,2,Multiple Choice,Laws and Regulations,What state decriminlized cannabis through the state legsialture in 2016?,4,Indiana,Pennsylvania,Ohio,Illinois,4
,,,,2,Multiple Choice,Laws and Regulations,In what year did Illinois decriminlize cannabis through the state legsilature?,4,2015,2010,2016,2001,3
,,,,2,Multiple Choice,Laws and Regulations,Ballot measures were approved in what states to legalize recreational cannabis in 2016?,4,"California, Indiana, Ohio, and Pennsylvania","Nevada, Maine, Kentucky, and Arizona","Arizona, California, Massachusetts, and Maine","California, Nevada, Maine, and Massachusetts",4
,,,,2,Multiple Choice,Laws and Regulations,Ballot measures were approved in what states to legalize medical cannabis in 2016?,4,"California, Nevada, and Maine","Florida, California, and Nevada","Arkansas, Florida, and North Dakota","Arkansas, Mississippi, and Delaware",3
,,,,2,Multiple Choice,Laws and Regulations,In what year was a ballot measure approved to leaglize recreational cannabis in California?,4,2002,2016,1996,2005,2
,,,,2,Multiple Choice,Laws and Regulations,In what year was a ballot measure approved to leaglize recreational cannabis in Nevada?,4,2002,2005,2016,2004,3
,,,,2,Multiple Choice,Laws and Regulations,In what year was a ballot measure approved to leaglize recreational cannabis in Maine?,4,1994,2015,2012,2016,4
,,,,2,Multiple Choice,Laws and Regulations,In what year was a ballot measure approved to leaglize recreational cannabis in Massachusetts?,4,1999,2017,2016,2012,3
,,,,2,Multiple Choice,Laws and Regulations,In what year was a ballot measure approved to legalize the medical use of cannabis in Arkansas?,4,2002,2016,2015,2011,2
,,,,2,Multiple Choice,Laws and Regulations,In what year was a ballot measure approved to legalize the medical use of cannabis in Florida?,4,1999,2002,2015,2016,4
,,,,2,Multiple Choice,Laws and Regulations,In what year was a ballot measure approved to legalize the medical use of cannabis in North Dakota?,4,2016,2015,1999,2005,1
,,,,2,Multiple Choice,Laws and Regulations,"In 2017, which state legalized the use of medical cannabis through the state legsilature?",4,New York,West Virginia,Ohio,Nevada,2
,,,,2,Multiple Choice,Laws and Regulations,West Virginia legalized the use of medical cannabis through the state legislature in what year?,4,2015,2010,2017,2011,3
,,,,2,Multiple Choice,Laws and Regulations,In what year did Oklahoma legalize medical cannabis through a ballot measure?,4,2018,2017,2015,2005,1
,,,,2,Multiple Choice,Laws and Regulations,What state legalized the medical use of cannabis through a ballot measure in 2017?,4,Oklahoma,Texas,Arizona,Nevada,1
,,,,2,Multiple Choice,Laws and Regulations,"In 2018, what state approved a ballot measure to legalize the recreational use of cannabis?",4,Michigan,Texas,Utah,MIssouri,1
,,,,2,Multiple Choice,Laws and Regulations,In what year did Michigan approve a ballot measure to legalize the recreational use of cannabis?,4,2017,2018,2009,2010,2
,,,,2,Multiple Choice,Laws and Regulations,In what year did New Mexico decriminalize cannabis through the state legsilature?,4,2019,2016,2018,2010,1
,,,,2,Multiple Choice,Laws and Regulations,"In 2019, which state decriminlized cannabis through the state legislature?",4,New Mexico,Arizona,Utah,MIssouri,1
,,,,2,Multiple Choice,Laws and Regulations,What US state was the first to license on-site marijuana consumption at cannabis stores?,4,California,Alaska,Washington,Nevada,2
,,,,2,Multiple Choice,Laws and Regulations,"In 1973, what state became the first in the US to decriminalize cannabis, reducing the penalty for up to an ounce to a $100 fine?",4,Alaska,California,Oregon,Texas,3
,,,,2,Multiple Choice,Laws and Regulations,"Texas law was amended in what year, to declare possession of four ounces or less a misdemeanor?",4,1972,1999,1989,1973,4
,,,,2,Multiple Choice,History,Cannabis is indigenous to what geographical area?,4,Central Asia,Pakistan,Japan,North America,1
,,,,2,Multiple Choice,Politics,Which Canadian cannabis activist founded the Marijuana Party of Canada in 2000?,4,Marc-Boris St-Maruice,Blair Longley,Marc Emery,None of the Above,1
,,,,2,Multiple Choice,Cannabis Freedom Fighters,Which of the following annual Vancouver cannabis events does cannabis activist Dana Larsen organize?,4,4/20 Celebration at Sunset Beach,Cannabis Day,Global Marijuana March,All of the Above,4
,,,,2,Multiple Choice,Legal Cannabis Worldwide,Cannabis is as common as grass in what country?,4,Nepal,Kingdom of Bhutan,Bangladesh,China,2
,,,,2,Multiple Choice,Legal Cannabis Worldwide,"Aurora Sky boasts an 800,000-square-foot greenhouse on 30 acres of land in what country?",4,Amsterdam,United States,Canada,United Kingdom,3
,,,,2,Multiple Choice,Definitions,The most psychoactive cannabinoid within the cannabis plant is ________?,4,Tetrahydrocannabinol (THC),Cannabidiol (CBD),Tetrahydrocannabivarinic Acid (THCVA),Cannabinol (CBN),1
,,,,2,Multiple Choice,Medical Benefits,What are the two types of cannabinoids receptors in our bodies called?,4,CB1 and CB2,RB2 and RB3,ECS1 and ECS2,CBD1 and CBD2,1
,,,,2,Multiple Choice,Medical Benefits,"The endocannabinoid system helps to regulate a lot of important functions within the human body, such as ________, __________, and ____________.",4,"temperature regulation, mood, and immune function","muscle memory, appetite, and bone density","libido, motor control, and digestion",,1
,,,,2,Multiple Choice,Medical Benefits,_______ _______ are located throughout the body and are part of the endocannabinoid system.,4,Cannabis receptors,Endocannabinoid receptors,Cannabinoid receptors,,3
,,,,2,Multiple Choice,Cannabis Freedom Fighters,"This cannabis advocate was the lead organizer and fundraiser for I-59, Washington D.C.'s medical cannabis initiative.",4,Bill Maher,Jack Herer,Steve DeAngelo,Nancy Pelosi,3
,,,,2,Multiple Choice,Legal Cannabis Worldwide,In what Canadian Province is it legal to consume cannabis in public where tobacco is also smoked?,4,Nova Scotia,All of the Above,Alberta,Ontario,2
,,,,2,Multiple Choice,Legal Cannabis Worldwide,What country was the first in the modern era to legalize cannabis as of December 2013?,4,Canada,South Africa,Uruguay,None of the Above,3
,,,,2,Multiple Choice,Cannabis Freedom Fighters,"Keith Stroup founded NORML (The National Organization for the Reform of Marijuana Laws) in 1970 using $5,000 in seed money from which foundation?",4,American Cancer Society,Ford Foundation,Playboy Foundation,The Reinberger Foundation,3
,,,,3,Multiple Choice,Growing Cannabis,The optimum root zone pH level for soilless growing mediums such as hydro or coco coir is:,4,5.5-6.5 pH,6.0-7.0 pH,4.2-5.5 pH,None of the Above,1
,,,,2,Multiple Choice,Medical Benefits,Which of these cannabinoids are known to be a neuroprotectant?,4,CBD,THC,CBDA,THCVA,2
,,,,2,Multiple Choice,Strains,Which of the following strains is a phenotype of White Widow?,4,White Rhino,Bubba Kush,98 Aloha White Widow,OG Kush,3
,,,,2,Multiple Choice,Strains,Cannabis strain 13 Dawgs is a hybrid strain created by crossing which two strains genetics?,4,G13 and Chemdawg,OG Kush and Chemdawg,G13 and Granddaddy Purple,Cherry Pie and Girl Scout Cookies,1
,,,,2,Multiple Choice,Strains,"What sativa-dominant hybrid shares the genetics from the strains Headband, Sour Diesel, and OG Kush?",4,Khalifa Kush,Granddaddy Purp,3 Kings,Harmony,3
,,,,2,Multiple Choice,Strains,"When crossing East Coast Panama Chunk and Sour Diesel you get 3rd Coast Panama Chunk, which is considered what type of strain?",4,Sativa Dominant Hybrid,Indica Dominant Hybrid,Indica,Sativa,1
,,,,2,Multiple Choice,Strains,501st OG is the product of Rare Dankness 1 and what strain?,4,Bubba Kush,XXX OG,Skywalker OG,541 Kush,3
,,,,2,Multiple Choice,Medical Benefits,The strain 501st OG has been widely used and recommended for the treatment of what?,4,Inflammation,Fatigue,Chronic Stress,None of the Above,3
,,,,2,Multiple Choice,Laws and Regulations,In 1976 which state decriminalized cannabis?,4,Nebraska,California,Minnesota,New York,3
,,,,2,Multiple Choice,Laws and Regulations,In what year did Mississippi decriminalize cannabis?,4,1979,1977,1980,1976,2
,,,,2,Multiple Choice,Laws and Regulations,In what year did New York decriminalize cannabis?,4,1981,1990,1977,1976,3
,,,,2,Multiple Choice,Laws and Regulations,In what year did North Carolina decriminalize cannabis?,4,1985,1992,1977,1978,3
,,,,2,Multiple Choice,Laws and Regulations,In what year did Nebraska decriminalize cannabis?,4,1999,1979,1985,1978,4
)


csv = CSV.parse(csv_text, :headers => true)
csv.each do |row|
  question = Trivia::MultipleChoiceAvailableQuestion.new(
    title: row["Question"],
    cooldown_period: 10,
    time_limit: 5,
    status: :published,
    complexity: row["Difficulty"]
  )
  question.topic = Trivia::Topic.where(name: row["Topic"]).first
  question.save!

  (1..row["Number of Answers"].to_i).each do |index|
    question.available_answers.create(
      name: row["Answer #{index}"],
      is_correct: row["Correct Answer"].to_i == index,
      status: :published
    )
  end
end
