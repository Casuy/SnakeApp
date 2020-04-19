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
    @State var showUpdate = false
    @Binding var showContent: Bool
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("Watching")
                        .font(.system(size: 28, weight: .bold))
                        .modifier(CustomFontModifier(size: 34))
                    
                    Spacer()
                    
                    AvatarView(showProfile: $showProfile)
                    
                    Button(action: { self.showUpdate.toggle() }) {
                        Image(systemName: "bell")
                            .renderingMode(.original)
                            .font(.system(size: 16, weight: .medium))
                            .frame(width: 36, height: 36)
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                    }
                    .sheet(isPresented: $showUpdate) {
                        UpdateList()
                    }
                }
                .padding(.horizontal)
                .padding(.leading, 14)
                .padding(.top, 30)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    WatchRingsView()
                        .padding(.horizontal, 30)
                        .padding(.bottom, 30)
                        .onTapGesture {
                            self.showContent = true
                    }
                }
                
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
                
                HStack {
                    Text("Courses")
                        .font(.title).bold()
                    Spacer()
                }
                .padding(.leading, 30)
                .offset(y: -60)

                SectionView(section: sectionData[2], width: screen.width - 60, height: 275)
                    .offset(y: -60)
                
                
                Spacer()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showProfile: .constant(false), showContent: .constant(true))
    }
}

struct SectionView: View {
    var section: Section
    var width: CGFloat = 275
    var height: CGFloat = 275
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text(section.title)
                    .font(.system(size: 24, weight: .bold))
                    .frame(width: 200, alignment: .leading)
                    .foregroundColor(.white)
                Spacer()
                Image(section.logo)
            }
            Text(section.text.uppercased())
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
    Section(title: "Bandy Bandy", text: "18 Sections", logo: "", image: Image(uiImage: #imageLiteral(resourceName: "bandy_bandy")), color: Color(#colorLiteral(red: 0.7372248769, green: 0.5804231763, blue: 0.4470093846, alpha: 1))),
    Section(title: "Carpet Python", text: "20 Sections", logo: "", image: Image(uiImage: #imageLiteral(resourceName: "carpet_python")), color: Color(#colorLiteral(red: 0.5881839991, green: 0.5804234743, blue: 0.4626886249, alpha: 1))),
    Section(title: "Coastal Taipan", text: "20 Sections", logo: "", image: Image(uiImage: #imageLiteral(resourceName: "coastal_taipan")), color: Color(#colorLiteral(red: 0.6039261222, green: 0.2666824162, blue: 0.2078307867, alpha: 1))),
    Section(title: "Common \nDeath Adder", text: "20 Sections", logo: "", image: Image(uiImage: #imageLiteral(resourceName: "common_death_adder")), color: Color(#colorLiteral(red: 0.2548547685, green: 0.3255104423, blue: 0.32936728, alpha: 1))),
    Section(title: "Eastern \nBrown Snake", text: "20 Sections", logo: "", image: Image(uiImage: #imageLiteral(resourceName: "eastern_brown_snake")), color: Color(#colorLiteral(red: 0.7372162342, green: 0.6235631704, blue: 0.5175873041, alpha: 1))),
    Section(title: "Lowland \nCopperhead", text: "20 Sections", logo: "", image: Image(uiImage: #imageLiteral(resourceName: "lowland_copperhead")), color: Color(#colorLiteral(red: 0.4195464253, green: 0.4941426516, blue: 0.2431051433, alpha: 1))),
    Section(title: "Mulga Snake", text: "20 Sections", logo: "", image: Image(uiImage: #imageLiteral(resourceName: "mulga_snake")), color: Color(#colorLiteral(red: 0.4784348011, green: 0.2078552246, blue: 0.1058855429, alpha: 1))),
    Section(title: "Red-Bellied \nBlack Snake", text: "20 Sections", logo: "", image: Image(uiImage: #imageLiteral(resourceName: "redbellied_black_snake")), color: Color(#colorLiteral(red: 0.5959804654, green: 0.7412180305, blue: 0.7136368155, alpha: 1))),
    Section(title: "Spotted Python", text: "20 Sections", logo: "", image: Image(uiImage: #imageLiteral(resourceName: "spotted_python")), color: Color(#colorLiteral(red: 0.7372277379, green: 0.5647352338, blue: 0.3803527355, alpha: 1))),
    Section(title: "Tiger Snake", text: "20 Sections", logo: "", image: Image(uiImage: #imageLiteral(resourceName: "tiger_snake")), color: Color(#colorLiteral(red: 0.5175920129, green: 0.5451271534, blue: 0.4077922404, alpha: 1))),
    Section(title: "Western \nBrown Snake", text: "20 Sections", logo: "", image: Image(uiImage: #imageLiteral(resourceName: "western_brown_snake")), color: Color(#colorLiteral(red: 0.6940664649, green: 0.6510158181, blue: 0.5607172847, alpha: 1))),
]



struct WatchRingsView: View {
    var body: some View {
        HStack(spacing: 30.0) {
            HStack(spacing: 12.0) {
                RingView(color1: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), color2: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), width: 44, height: 44, percent: 68, show: .constant(true))
                
                VStack(alignment: .leading, spacing: 4.0) {
                    Text("6 minutes left").bold().modifier(FontModifier(style: .subheadline))
                    Text("Watched 10 mins today").modifier(FontModifier(style: .caption))
                }
                .modifier(FontModifier())
            }
            .padding(8)
            .background(Color.white)
            .cornerRadius(20)
            .modifier(ShadowModifier())
            
            HStack(spacing: 12.0) {
                RingView(color1: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), color2: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), width: 32, height: 32, percent: 54, show: .constant(true))
            }
            .padding(8)
            .background(Color.white)
            .cornerRadius(20)
            .modifier(ShadowModifier())
            
            HStack(spacing: 12.0) {
                RingView(color1: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), color2: #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), width: 32, height: 32, percent: 32, show: .constant(true))
            }
            .padding(8)
            .background(Color.white)
            .cornerRadius(20)
            .modifier(ShadowModifier())
        }
    }
}
