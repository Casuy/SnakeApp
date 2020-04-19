//
//  SnakeDetail.swift
//  SnakeApp
//
//  Created by Casuy on 19/4/20.
//  Copyright © 2020 Casuy. All rights reserved.
//

import SwiftUI

struct SnakeDetail: View {
    var snake: Snake
    @Binding var show: Bool
    @Binding var active: Bool
    @Binding var activeIndex: Int
    
    var body: some View {
        ScrollView {
            VStack {
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
                            VStack {
                                Image(systemName: "xmark")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.white)
                            }
                            .frame(width: 36, height: 36)
                            .background(Color.black.opacity(0.6))
                            .clipShape(Circle())
                            .onTapGesture {
                                self.show = false
                                self.active = false
                                self.activeIndex = -1
                            }
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
                .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? 460 : 280)
                .background(Color(snake.color))
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: Color(snake.color).opacity(0.3), radius: 20, x: 0, y: 20)
                
                VStack(alignment: .leading, spacing: 30.0) {
                    Text("The bandy-bandy (Vermicella annulata), also commonly known as the hoop snake, is a species of venomous snake in the family Elapidae. The species is endemic to Australia. It is considered weakly venomous.")
                    
                    Text("About this snake")
                        .font(.title).bold()
                    
                    Text("The bandy-bandy is marked with alternating black and white or yellowish rings, which give the species both its common names and its scientific name (from the diminutive form, annul-, of the Latin anus, meaning \"ring\"). Though since 1996, only five species of bandy-bandies were thought to be in the genus Vermicella, the discovery of another species (V. parscauda) on a peninsula in Australia's far north indicates more species of bandy-bandies may exist.")
                    
                    Text("Despite being an elapid, Bandy-bandy is weakly venomous with localized symptoms around the bite area. It is generally considered harmless due to the small size of its mouth and its inoffensive nature.")
                }
                .padding(30)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct SnakeDetail_Previews: PreviewProvider {
    static var previews: some View {
        SnakeDetail(snake: snakeData[0], show: .constant(true), active: .constant(true), activeIndex: .constant(-1))
    }
}
