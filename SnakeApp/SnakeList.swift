//
//  SnakeList.swift
//  SnakeApp
//
//  Created by Casuy on 19/4/20.
//  Copyright © 2020 Casuy. All rights reserved.
//

import SwiftUI

struct SnakeList: View {
    @State var show = false
    @State var show2 = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                SnakeView(show: $show)
                GeometryReader { geometry in
                    SnakeView(show: self.$show2)
                        .offset(y: self.show2 ? -geometry.frame(in: .global).minY : 0)
                }
                .frame(height: show2 ? screen.height : 280)
                .frame(maxWidth: show2 ? .infinity : screen.width - 60)
            }
            .frame(width: screen.width)
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
                        Text("Bandy-Bandy")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                        Text("Vermicella Annulata")
                            .foregroundColor(Color.white.opacity(0.7))
                    }
                    
                    Spacer()
                    
                    ZStack {
                        Image(uiImage: #imageLiteral(resourceName: "Logo1"))
                            .opacity(show ? 0 : 1)
                        
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
                Image(uiImage: #imageLiteral(resourceName: "Card2"))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .frame(height: 140, alignment: .top)
            }
            .padding(show ? 30 : 20)
            .padding(.top, show ? 30 : 0)
    //        .frame(width: show ? screen.width : screen.width - 60, height: show ? screen.height : 280)
                .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? 460 : 280)
            .background(Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)).opacity(0.3), radius: 20, x: 0, y: 20)
            
            .onTapGesture {
                self.show.toggle()
            }
            
        }
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        .edgesIgnoringSafeArea(.all)
    }
}
