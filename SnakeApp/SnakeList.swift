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
    
    var body: some View {
        ZStack {
            Color.black.opacity(active ? 0.5 : 0)
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
                            SnakeView(show: self.$snakes[index].show, active: self.$active, snake: self.snakes[index])
                                .offset(y: self.snakes[index].show ? -geometry.frame(in: .global).minY : 0)
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
    @Binding var active: Bool
    var snake: Snake
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 30.0) {
                Text("The bandy-bandy (Vermicella annulata), also commonly known as the hoop snake, is a species of venomous snake in the family Elapidae. The species is endemic to Australia. It is considered weakly venomous.")
                
                Text("About this snake")
                    .font(.title).bold()
                
                Text("The bandy-bandy is marked with alternating black and white or yellowish rings, which give the species both its common names and its scientific name (from the diminutive form, annul-, of the Latin anus, meaning \"ring\"). Though since 1996, only five species of bandy-bandies were thought to be in the genus Vermicella, the discovery of another species (V. parscauda) on a peninsula in Australia's far north indicates more species of bandy-bandies may exist.")
                
                Text("Despite being an elapid, V. annulata is weakly venomous with localized symptoms around the bite area. It is generally considered harmless due to the small size of its mouth and its inoffensive nature.")
            }
            .padding(30)
            .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? .infinity : 280, alignment: .top)
            .offset(y: show ? 460 : 0)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
            .opacity(show ? 1 : 0)
            
            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 8.0) {
                        Text(snake.title)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                        Text(snake.subtitle)
                            .foregroundColor(Color.white.opacity(0.7))
                    }
                    
                    Spacer()
                    
                    ZStack {
//                        Image(uiImage: #imageLiteral(resourceName: "Logo1"))
//                            .opacity(show ? 0 : 1)
                        
                        VStack {
                            Image(systemName: "xmark")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white)
                        }
                        .frame(width: 36, height: 36)
                        .background(Color.black)
                        .clipShape(Circle())
                        .opacity(show ? 1 : 0)
                    }
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
    //        .frame(width: show ? screen.width : screen.width - 60, height: show ? screen.height : 280)
                .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? 460 : 280)
                .background(Color(snake.color))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: Color(snake.color).opacity(0.3), radius: 20, x: 0, y: 20)
            
            .onTapGesture {
                self.show.toggle()
                self.active.toggle()
            }
            
        }
        .frame(height: show ? screen.height : 280)
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        .edgesIgnoringSafeArea(.all)
    }
}

struct Snake: Identifiable {
    var id = UUID()
    var title: String
    var subtitle: String
    var image: UIImage
//    var logo: UIImage
    var color: UIColor
    var show: Bool
}

var snakeData = [
    Snake(title: "Bandy-Bandy", subtitle: "Vermicella Annulata", image: #imageLiteral(resourceName: "bandy_bandy"), color: #colorLiteral(red: 0.7372248769, green: 0.5804231763, blue: 0.4470093846, alpha: 1), show: false),
    Snake(title: "Carpet Python", subtitle: "Morelia Spilota", image: #imageLiteral(resourceName: "carpet_python"), color: #colorLiteral(red: 0.5881839991, green: 0.5804234743, blue: 0.4626886249, alpha: 1), show: false),
    Snake(title: "Coastal Taipan", subtitle: "Oxyuranus Scutellatus", image: #imageLiteral(resourceName: "coastal_taipan"), color: #colorLiteral(red: 0.6039261222, green: 0.2666824162, blue: 0.2078307867, alpha: 1), show: false),
    Snake(title: "Common \nDeath Adder", subtitle: "Acanthophis Antarcticus", image: #imageLiteral(resourceName: "common_death_adder"), color: #colorLiteral(red: 0.2548547685, green: 0.3255104423, blue: 0.32936728, alpha: 1), show: false),
    Snake(title: "Eastern \nBrown Snake", subtitle: "Pseudonaja Textilis", image: #imageLiteral(resourceName: "eastern_brown_snake"), color: #colorLiteral(red: 0.7372162342, green: 0.6235631704, blue: 0.5175873041, alpha: 1), show: false),
    Snake(title: "Lowland \nCopperhead", subtitle: "Austrelaps Superbus", image: #imageLiteral(resourceName: "lowland_copperhead"), color: #colorLiteral(red: 0.4195464253, green: 0.4941426516, blue: 0.2431051433, alpha: 1), show: false),
    Snake(title: "Mulga Snake", subtitle: "Pseudechis Australis", image: #imageLiteral(resourceName: "mulga_snake"), color: #colorLiteral(red: 0.4784348011, green: 0.2078552246, blue: 0.1058855429, alpha: 1), show: false),
    Snake(title: "Red-Bellied \nBlack Snake", subtitle: "Pseudechis Porphyriacus", image: #imageLiteral(resourceName: "redbellied_black_snake"), color: #colorLiteral(red: 0.5959804654, green: 0.7412180305, blue: 0.7136368155, alpha: 1), show: false),
    Snake(title: "Spotted Python", subtitle: "Antaresia Maculosa", image: #imageLiteral(resourceName: "spotted_python"), color: #colorLiteral(red: 0.7372277379, green: 0.5647352338, blue: 0.3803527355, alpha: 1), show: false),
    Snake(title: "Tiger Snake", subtitle: "Notechis scutatus", image: #imageLiteral(resourceName: "tiger_snake"), color: #colorLiteral(red: 0.5175920129, green: 0.5451271534, blue: 0.4077922404, alpha: 1), show: false),
    Snake(title: "Western \nBrown Snake", subtitle: "Pseudonaja Nuchalis", image: #imageLiteral(resourceName: "western_brown_snake"), color: #colorLiteral(red: 0.8548869491, green: 0.560811162, blue: 0.1176914498, alpha: 1), show: false),
]
 
