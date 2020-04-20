//
//  HomeView.swift
//  SnakeApp
//
//  Created by Casuy on 16/4/20.
//  Copyright © 2020 Casuy. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @Binding var showProfile: Bool
    @Binding var showContent: Bool
    
    var body: some View {
        
        ScrollView {
            VStack {
                HStack {
                    Text("SnakeApp")
                        .font(.largeTitle).bold()
                        .modifier(CustomFontModifier(size: 34))
                    
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.leading, 14)
                .padding(.top, 30)
                
                ButtonsView()
                    .padding(.horizontal, 30)
                    .padding(.bottom, 30)
                
                HStack {
                    Text("Snakes")
                        .font(.title).bold()
                    Spacer()
                }
                .padding(.leading, 30)
                .padding(.bottom, 5)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack (spacing: 20) {
                        ForEach(sectionData) { item in
                            GeometryReader { geometry in
                                SectionView(section: item)
                                    .rotation3DEffect(Angle(degrees:
                                        Double(geometry.frame(in: .global).minX - 30) / -20
                                    ), axis: (x: 0, y: 10, z: 0))
                            }
                            .frame(width: 275, height: 275)
                        }
                    }
                    .padding(30)
                    .padding(.bottom, 30)
                }
                .offset(y: -30)
                
                Text("—— Project Info ——").font(.subheadline)
                    .foregroundColor(Color.gray)
                    .onTapGesture {
                        self.showContent = true
                }
                
                Spacer()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showProfile: .constant(false), showContent: .constant(true)).previewDevice("iPhone X")
    }
}

struct SectionView: View {
    var section: Section
    var width: CGFloat = 290
    var height: CGFloat = 290
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text(section.title)
                    .font(.system(size: 24, weight: .bold))
                    .frame(width: 200, alignment: .leading)
                    .foregroundColor(.white)
                Spacer()
            }
            Text(section.text)
                .foregroundColor(Color.white.opacity(0.7))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            section.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 150)
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .frame(width: width, height: height)
        .background(section.color)
        .cornerRadius(30)
        .shadow(color: section.color.opacity(0.3), radius: 20, x: 0, y: 20)
    }
}

struct Section: Identifiable {
    var id = UUID()
    var title: String
    var text: String
    var logo: String
    var image: Image
    var color: Color
}

let sectionData = [
    Section(title: "Bandy Bandy", text: "Vermicella Annulata", logo: "", image: Image(uiImage: #imageLiteral(resourceName: "bandy_bandy")), color: Color(#colorLiteral(red: 0.7372248769, green: 0.5804231763, blue: 0.4470093846, alpha: 1))),
    Section(title: "Carpet Python", text: "Morelia Spilota", logo: "", image: Image(uiImage: #imageLiteral(resourceName: "carpet_python")), color: Color(#colorLiteral(red: 0.5881839991, green: 0.5804234743, blue: 0.4626886249, alpha: 1))),
    Section(title: "Coastal Taipan", text: "Oxyuranus Scutellatus", logo: "", image: Image(uiImage: #imageLiteral(resourceName: "coastal_taipan")), color: Color(#colorLiteral(red: 0.6039261222, green: 0.2666824162, blue: 0.2078307867, alpha: 1))),
    Section(title: "Common \nDeath Adder", text: "Acanthophis Antarcticus", logo: "", image: Image(uiImage: #imageLiteral(resourceName: "common_death_adder")), color: Color(#colorLiteral(red: 0.2548547685, green: 0.3255104423, blue: 0.32936728, alpha: 1))),
    Section(title: "Eastern \nBrown Snake", text: "Pseudonaja Textilis", logo: "", image: Image(uiImage: #imageLiteral(resourceName: "eastern_brown_snake")), color: Color(#colorLiteral(red: 0.7372162342, green: 0.6235631704, blue: 0.5175873041, alpha: 1))),
    Section(title: "Lowland \nCopperhead", text: "Austrelaps Superbus", logo: "", image: Image(uiImage: #imageLiteral(resourceName: "lowland_copperhead")), color: Color(#colorLiteral(red: 0.4195464253, green: 0.4941426516, blue: 0.2431051433, alpha: 1))),
    Section(title: "Mulga Snake", text: "Pseudechis Australis", logo: "", image: Image(uiImage: #imageLiteral(resourceName: "mulga_snake")), color: Color(#colorLiteral(red: 0.4784348011, green: 0.2078552246, blue: 0.1058855429, alpha: 1))),
    Section(title: "Red-Bellied \nBlack Snake", text: "Pseudechis Porphyriacus", logo: "", image: Image(uiImage: #imageLiteral(resourceName: "redbellied_black_snake")), color: Color(#colorLiteral(red: 0.5959804654, green: 0.7412180305, blue: 0.7136368155, alpha: 1))),
    Section(title: "Spotted Python", text: "Antaresia Maculosa", logo: "", image: Image(uiImage: #imageLiteral(resourceName: "spotted_python")), color: Color(#colorLiteral(red: 0.7372277379, green: 0.5647352338, blue: 0.3803527355, alpha: 1))),
    Section(title: "Tiger Snake", text: "Notechis scutatus", logo: "", image: Image(uiImage: #imageLiteral(resourceName: "tiger_snake")), color: Color(#colorLiteral(red: 0.5175920129, green: 0.5451271534, blue: 0.4077922404, alpha: 1))),
    Section(title: "Western \nBrown Snake", text: "Pseudonaja Nuchalis", logo: "", image: Image(uiImage: #imageLiteral(resourceName: "western_brown_snake")), color: Color(#colorLiteral(red: 0.8548869491, green: 0.560811162, blue: 0.1176914498, alpha: 1))),
]



struct ButtonsView: View {
    @State var showUpdate = false
    @State var showClassification = false
    
    var body: some View {
        
        HStack(spacing: 30.0) {
            
            HStack() {
                
                Button(action: { self.showClassification.toggle() }) {
                    HStack {
                        Image(systemName: "camera")
                            .renderingMode(.original)
                            .font(.system(size: 18, weight: .medium))
                            .frame(width: 36, height: 36)
                        
                        Text("Take photo").bold().modifier(FontModifier(style: .subheadline))
                            .foregroundColor(Color.black)
                            .modifier(FontModifier())
                            .padding(.trailing, 5)
                    }
                }
                .sheet(isPresented: $showClassification) {
                    CameraView()
                }
            }
            .padding(8)
            .background(Color.white)
            .cornerRadius(20)
            .modifier(ShadowModifier())
            
            HStack() {
                Button(action: { self.showUpdate.toggle() }) {
                    HStack {
                        Image(systemName: "rectangle.stack")
                            .renderingMode(.original)
                            .font(.system(size: 18, weight: .medium))
                            .frame(width: 36, height: 36)
                        Text("Past result").bold().modifier(FontModifier(style: .subheadline))
                            .foregroundColor(Color.black)
                            .modifier(FontModifier())
                            .padding(.trailing, 5)
                    }
                }
                .sheet(isPresented: $showUpdate) {
                    UpdateList()
                }
            }
            .padding(8)
            .background(Color.white)
            .cornerRadius(20)
            .modifier(ShadowModifier())
        }
    }
}
