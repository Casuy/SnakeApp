//
//  SnakeList.swift
//  SnakeApp
//
//  Created by Casuy on 19/4/20.
//  Copyright © 2020 Casuy. All rights reserved.
//

import SwiftUI

struct SnakeList: View {
    @State var snakes = snakeData
    @State var active = false
    @State var activeIndex = -1
    @State var activeView = CGSize.zero
    
    var body: some View {
        ZStack {
            Color.black.opacity(Double(self.activeView.height / 500))
                .animation(.linear)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(spacing: 30) {
                    Text("Snakes")
                        .font(.largeTitle).bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 30)
                        .padding(.top, 30)
                        .blur(radius: active ? 20 : 0)
                    
                    ForEach(snakes.indices, id: \.self) { index in
                        GeometryReader { geometry in
                            SnakeView(
                                show: self.$snakes[index].show,
                                snake: self.snakes[index],
                                active: self.$active,
                                index: index,
                                activeIndex: self.$activeIndex,
                                activeView: self.$activeView
                            )
                                .offset(y: self.snakes[index].show ? -geometry.frame(in: .global).minY : 0)
                                .opacity(self.activeIndex != index && self.active ? 0 : 1)
                                .scaleEffect(self.activeIndex != index && self.active ? 0.5 : 1)
                                .offset(x: self.activeIndex != index && self.active ? screen.width : 0)
                        }
                        .frame(height: 280)
                        .frame(maxWidth: self.snakes[index].show ? .infinity : screen.width - 60)
                        .zIndex(self.snakes[index].show ? 1 : 0)
                    }
                }
                .frame(width: screen.width)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            }
            .statusBar(hidden: active ? true : false)
            .animation(.linear)
        }
    }
}

struct SnakeList_Previews: PreviewProvider {
    static var previews: some View {
        SnakeList()
    }
}

struct SnakeView: View {
    @Binding var show: Bool
    var snake: Snake
    @Binding var active: Bool
    var index: Int
    @Binding var activeIndex: Int
    @Binding var activeView: CGSize
    
    
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 8.0) {
                        Text(snake.title)
                            .font(.system(size: show ? 30 : 24, weight: .bold))
                            .foregroundColor(.white)
                        Text(snake.subtitle)
                            .foregroundColor(Color.white.opacity(0.7))
                    }
                    
                    Spacer()
                    
                }
                Spacer()
                Image(uiImage: snake.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .frame(height: snake.show ? 220 : 140, alignment: .top)
            }
            .padding(show ? 30 : 20)
            .padding(.top, show ? 30 : 0)
            .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? 460 : 280)
            .background(Color(snake.color))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color(snake.color).opacity(0.3), radius: 20, x: 0, y: 20)
            .onTapGesture {
                self.show.toggle()
                self.active.toggle()
                if self.show {
                    self.activeIndex = self.index
                } else {
                    self.activeIndex = -1
                }
            }
            
            if show {
                SnakeDetail(snake: snake, show: $show, active: $active, activeIndex: $activeIndex)
                    .background(Color.white)
                    .animation(nil)
            }
            
        }
        .frame(height: show ? screen.height : 280)
        .scaleEffect(1 - self.activeView.height / 1000)
        .rotation3DEffect(Angle(degrees: Double(self.activeView.height / 10)), axis: (x: 0, y: 10.0, z: 0))
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        .edgesIgnoringSafeArea(.all)
    }
}

struct Snake: Identifiable {
    var id = UUID()
    var title: String
    var subtitle: String
    var image: UIImage
    var color: UIColor
    var show: Bool
    var intro: String
    var text1: String
    var text2: String
    var text3: String
}

var snakeData = [
    Snake(title: "Bandy-Bandy", subtitle: "Vermicella Annulata", image: #imageLiteral(resourceName: "bandy_bandy"), color: #colorLiteral(red: 0.7372248769, green: 0.5804231763, blue: 0.4470093846, alpha: 1), show: false, intro: "The bandy-bandy (Vermicella annulata), also commonly known as the hoop snake, is a species of venomous snake in the family Elapidae. The species is endemic to Australia. It is considered weakly venomous.", text1: "Bandy Bandys have 48 or more sharply contrasting black and white rings fully encircling the body.  The eyes are small and the tail is bluntly-tipped.  This species grows to 76 cm.  Midbody scale rows 15; ventrals 180–260; anal divided; subcaudals divided 12–30.", text2: "This snake is a burrowing, nocturnal species that is often found sheltering beneath rocks and logs.  It is sometimes seen crossing roads on humid nights.  When threatened, this snake raises loops of the body vertically off the ground.  The significance of this display is unknown, but probably serves to confuse predators.  It may also help to protect the snake's head which remains on the ground.", text3: "The venom of this species is poorly known.  One case of snake-bite with moderately severe local symptoms has been reported.  Apply first aid and seek urgent medical attention for all suspected bites."),
    Snake(title: "Carpet Python", subtitle: "Morelia Spilota", image: #imageLiteral(resourceName: "carpet_python"), color: #colorLiteral(red: 0.5881839991, green: 0.5804234743, blue: 0.4626886249, alpha: 1), show: false, intro: "Carpet python, commonly referred to as the morelia spilota or diamond python, is a large snake of the family Pythonidae found in Australia, New Guinea (Indonesia and Papua New Guinea), Bismarck Archipelago, and the northern Solomon Islands.", text1: "Carpet snakes are extremely variable in colour and pattern.  Most specimens are olive green, with pale, dark-edged blotches, stripes or cross-bands.  The juveniles are similarly patterned, but often in shades of brown rather than olive green. A row of deep pits can be seen along the lower jaw and many small scales are present on the top of the head. This species can grow to more than 3 m in length.  Midbody scale rows 40–65; ventrals 240–310, narrow; anal single; subcaudals divided 60–95.", text2: "Lives in open forests, rainforests, coastal heaths, rural lands, park lands and suburban gardens. This snake is active both day and night and can be encountered on the ground, in trees or buildings (particularly chicken pens, barns and attics).", text3: "This species is non-venomous, but tetanus protection is recommended following bites."),
    Snake(title: "Coastal Taipan", subtitle: "Oxyuranus Scutellatus", image: #imageLiteral(resourceName: "coastal_taipan"), color: #colorLiteral(red: 0.6039261222, green: 0.2666824162, blue: 0.2078307867, alpha: 1), show: false, intro: "Confident in its own splendid lethality, the Coastal Taipan is not one to back away from a close or surprise encounter. However, given the chance (and plenty of space), this maligned and misunderstood snake will always prefer a vanishing act over a showdown.", text1: "The Coastal Taipan is usually light olive to dark russet brown but sometimes dark grey to black. The head has an angular brow and is lighter coloured on the face. The eye is a reddish colour.  The belly is cream and usually marked with orange or pink flecks. This species grows to 2.9 metres. Midbody scale rows 21 or 23; ventrals 220–250; anal single; subcaudals divided 57–75.", text2: "Lives in open forests, dry closed forests, coastal heaths and grassy beach dunes. It also favours cultivated areas such as cane fields. This species is active during day and also in early evening during hot weather.", text3: "This is a dangerously venomous species with strongly neurotoxic venom. It possesses the third most toxic land snake venom known. Many human deaths have resulted from bites by this species. If bitten, apply first aid and seek urgent medical attention."),
    Snake(title: "Common \nDeath Adder", subtitle: "Acanthophis Antarcticus", image: #imageLiteral(resourceName: "common_death_adder"), color: #colorLiteral(red: 0.2548547685, green: 0.3255104423, blue: 0.32936728, alpha: 1), show: false, intro: "The Common Death Adder is a species of death adder native to Australia. It is one of the most venomous land snakes in Australia and globally. While it remains widespread (unlike related species), it is facing increased threat from the ongoing Australian cane toad invasion.", text1: "The Common Death Adder has a stocky body with an arrow-shaped head. The tail tip is thin and ends with a short spine.  The back can be shades of grey to reddish-brown and is usually marked with lighter bands. The belly is greyish to cream. Grows to 75cm. Midbody scale rows 21–23; ventrals 110–135; anal single; subcaudals, mostly single, some divided at tail-tip 35–60.", text2: "Lives in wet and dry eucalypt forests, woodlands and coastal heaths. Usually sits motionless concealed in leaf-litter. This species is encountered both day and night.", text3: "This is a dangerously venomous snake with strongly neurotoxic venom. It is responsible for human deaths. If bitten, apply first aid and seek urgent medical attention."),
    Snake(title: "Eastern \nBrown Snake", subtitle: "Pseudonaja Textilis", image: #imageLiteral(resourceName: "eastern_brown_snake"), color: #colorLiteral(red: 0.7372162342, green: 0.6235631704, blue: 0.5175873041, alpha: 1), show: false, intro: "Broad-scale clearing of land for agriculture, while disastrous for many native creatures, has proved a boon for the Eastern Brown Snake, and their numbers have proliferated thanks to the ready supply of rodents that followed. Despite the free pest control they offer to farmers and landholders, brown snakes are still widely seen as dangerous pests themselves.", text1: "The Eastern Brown Snake may be any shade of brown but can also be grey or black. Some individuals are banded. The belly is typically cream with pink or orange spots. Juveniles may be plain or banded and have distinctive head markings consisting of a black blotch on the crown and a dark neck band. This species grows to 2 metres. Midbody scale rows 17; ventrals 185–235; anal divided; subcaudals divided 45–75.", text2: "Found in all habitats except rainforest. It has adapted well to farmed, grazed and semi-urban lands. In South-eastern Queensland, this species is particularly common around Beenleigh and Ipswich. This species is active by day, although young Eastern Brown Snakes are often encountered at night.", text3: "This species is dangerously venomous and has been responsible for many human deaths. The venom is strongly neurotoxic. If bitten, apply first aid and seek urgent medical attention."),
    Snake(title: "Lowland \nCopperhead", subtitle: "Austrelaps Superbus", image: #imageLiteral(resourceName: "lowland_copperhead"), color: #colorLiteral(red: 0.4195464253, green: 0.4941426516, blue: 0.2431051433, alpha: 1), show: false, intro: "Copperheads have managed to eke out an existence in some of the coldest high rainfall regions of Australia, where most other snakes would perish. And one species at least appears to have benefitted from European settlement, with the conversion of forest to open agricultural country creating more favorable habitat for this moisture-loving serpent.", text1: "All species of copperheads are fairly similar in general form and colouration. The scales of the back and upper sides are semi-glossy and uniformly blackish to grey brown in colour, with a brownish or orange flush in some individuals of Lowland and Highland Copperheads. The lowermost rows of lateral scales are enlarged and these are usually a paler colour, particularly on the neck and forebody. Belly colour is cream to grey. The head is relatively narrow and barely distinct from the neck. The upper labials are characteristically “barred” with a whitish anterior edge. The eyes are moderately large, pale coloured with a brown to reddish-brown rim, and the pupil is round.", text2: "The venom is powerfully neurotoxic, haemolytic and cytotoxic, and a bite from an adult of any of the species may be potentially fatal without medical assistance.", text3: ""),
    Snake(title: "Mulga Snake", subtitle: "Pseudechis Australis", image: #imageLiteral(resourceName: "mulga_snake"), color: #colorLiteral(red: 0.4784348011, green: 0.2078552246, blue: 0.1058855429, alpha: 1), show: false, intro: "As debate continues over its taxonomic identity, there’s no doubting the Mulga Snake’s status as one of Australia’s most formidable snakes.", text1: "The Mulga Snake is heavily built and has a wide head. Its back colour varies from brown to olive-green. The belly is cream and unmarked. This is Australia’s largest venomous snake, growing to 3 metres. Midbody scale rows 17; ventrals 185–225; anal divided; subcaudals single at front, remainder divided, 50–75.", text2: "Lives in dry open forests and grasslands. This species is active both day and night.", text3: "This is a dangerously venomous species with strongly haemotoxic venom. It is a ready biter and has been responsible for human deaths. If bitten, apply first aid and seek urgent medical attention."),
    Snake(title: "Red-Bellied \nBlack Snake", subtitle: "Pseudechis Porphyriacus", image: #imageLiteral(resourceName: "redbellied_black_snake"), color: #colorLiteral(red: 0.5959804654, green: 0.7412180305, blue: 0.7136368155, alpha: 1), show: false, intro: "This beautiful serpent shares our love of sunshine and water, and is a familiar sight to many outdoor adventurers in eastern Australia. Attitudes towards these largely inoffensive snakes are slowly changing, however they are still often seen as a dangerous menace and unjustly persecuted.", text1: "The Red-bellied Black Snake has a shiny, immaculate black back and the tip of the snout is brown.  The belly is cream, but each scale has a dark hind edge.  There is red on the lower flanks.  This species grows to 2 metres.  Midbody scale rows 17; ventrals 170–215; anal paired; subcaudals single at front, remainder divided 40–65.", text2: "Usually found in well watered areas such as river and creek banks and swamps.  Also known from rainforests, wet eucalypt forests and heaths. This species is active by day.", text3: "A dangerously venomous species with strongly haemotoxic and cytotoxic venom.  If bitten, apply first aid and seek urgent medical attention."),
    Snake(title: "Spotted Python", subtitle: "Antaresia Maculosa", image: #imageLiteral(resourceName: "spotted_python"), color: #colorLiteral(red: 0.7372277379, green: 0.5647352338, blue: 0.3803527355, alpha: 1), show: false, intro: "The Spotted Python is one of the shortest python species, growing to only a metre. Its ‘spots’ are really blotches of dark brown on a light brown background. Sometimes the spots join together so they look almost like stripes, especially near the head and tail. Due to their short length, lack of venom and docile nature, spotted pythons are often kept as pets.", text1: "Solidly-built snake but not as large as the Coastal Carpet Python. Fawn or pale-brown ground colour with contrasting dark, chocolatey-brown mottled & blotched pattern and color. Mostly cream on the underside. Head is distinct from the neck. Midbody scales at 37- 44 rows.", text2: "Spotted pythons are found on the north-east to eastern coast of Australia, from Cape York in Queensland to northern NSW. They favour wet forests to dry woodlands, river banks, and areas with rocks, particularly caves that are home to bats.", text3: ""),
    Snake(title: "Tiger Snake", subtitle: "Notechis scutatus", image: #imageLiteral(resourceName: "tiger_snake"), color: #colorLiteral(red: 0.5175920129, green: 0.5451271534, blue: 0.4077922404, alpha: 1), show: false, intro: "Most Australians know of tiger snakes and are aware of their fearsome reputation, though few people will ever encounter one. Unfortunately this species is much maligned because of its aggressive nature and toxic venom; however the tiger snake should be recognised as a great survivor, superbly adapted to some of the most inhospitable environments in Australia.", text1: "The Tiger Snake has a solid build and a large, flat head. The back is usually olive green to brown with numerous ‘ragged' crossbands. The belly is cream to grey. This species grows to 2 metres. Midbody scale rows 17–19 (rarely 15); ventrals 140–190; anal single; subcaudals single 35–65.", text2: "This species is mainly found in moist areas; rainforests, heaths, open forests and river floodplains. And it is active by day but is also nocturnal in warm weather.", text3: "Tiger Snakes are dangerously venomous. Their venom is strongly neurotoxic and haemotoxic and bites have resulted in many human deaths. If bitten, apply first aid and seek urgent medical attention. "),
    Snake(title: "Western \nBrown Snake", subtitle: "Pseudonaja Nuchalis", image: #imageLiteral(resourceName: "western_brown_snake"), color: #colorLiteral(red: 0.8548869491, green: 0.560811162, blue: 0.1176914498, alpha: 1), show: false, intro: "For many years it was suspected that the widespread Western Brown Snake (Pseudonaja nuchalis) was in fact a composite species, however efforts to split nuchalis were largely defeated by the extreme level of colour and pattern variation encountered both within and between populations. Ontogenetic colour changes, suggestions of intergrades, and possible hybridisation with other Pseudonaja species added to the confusion. Despite the enormous challenge researchers were able to narrow down a number of basic colour morphs, and recent genetic studies have now built upon earlier findings to confirm the existence of at least three species within the nuchalis-complex.", text1: "The Western Brown Snakes is highly variable in colour pattern. The back can be any shade of brown and may be plain but is often patterned with darker flecks or bands. The head may be brown or black and the belly is cream with orange or grey spotting. Juveniles may be plain or banded but usually have distinctive head markings consisting of a black blotch on the crown and a dark neck band. This species grows to 1.6 metres. Midbody scale rows 17–19; ventrals180–230; anal divided; subcaudals divided 50–70.", text2: "Lives in dry open forests, grasslands and scrublands. This species is active by day but may be nocturnal in hot weather.", text3: "A dangerously venomous species with neurotoxic and haemotoxic venom. If bitten, apply first aid and seek urgent medical attention."),
]
 
