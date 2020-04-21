//
//  CameraView.swift
//  SnakeApp
//
//  Created by Casuy on 20/4/20.
//  Copyright © 2020 Casuy. All rights reserved.
//

import SwiftUI

struct CameraView: View {
    @Environment(\.managedObjectContext) var moc
    
    @State var name = "Bandy-Bandy"
    @State var confidence = "78.2%"
    @State var image1 : Data = .init(count: 0)
    
    @State var image: Image?
    @State var showingImagePicker = false
    @State var inputImage: UIImage?
    @State var useCamera = false
    @State var selected = false
    @State var showResult = false
    
    var body: some View {
        
        VStack {
            HStack {
                Text("Identify Snake")
                    .font(.largeTitle).bold()
                    .modifier(CustomFontModifier(size: 34))
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.leading, 14)
            .padding(.top, 30)
            
            ImageView(
                image: self.$image,
                selected: self.$selected,
                showResult: self.$showResult,
                name: self.$name,
                confidence: self.$confidence)
            
            Spacer()
            
            HStack(alignment: .center, spacing: 40) {
                Image(systemName: "camera")
                    .foregroundColor(.primary)
                    .font(.system(size: 18, weight: .medium))
                    .frame(width: 50, height: 50)
                    .background(Color("background3"))
                    .clipShape(Circle())
                    .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                    .onTapGesture {
                        self.useCamera = true
                        self.showingImagePicker = true
                        self.selected = true
                        self.showResult = false
                }
                
                ZStack {
                    Circle()
                        .fill(Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)))
                        .frame(width: 60, height: 60)
                    
                    Circle()
                        .stroke(Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)), style: StrokeStyle(lineWidth: 1))
                        .frame(width: 70, height: 70)
                        .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                    
                }
                .onTapGesture {
                    self.showResult = true
                }
                
                Image(systemName: "rectangle.stack")
                    .foregroundColor(.primary)
                    .font(.system(size: 18, weight: .medium))
                    .frame(width: 50, height: 50)
                    .background(Color("background3"))
                    .clipShape(Circle())
                    .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                    .onTapGesture {
                        self.useCamera = false
                        self.showingImagePicker = true
                        self.selected = true
                        self.showResult = false
                }
            }
            .padding(.bottom, 50)
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage, useCamera: self.$useCamera)
        }
        
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView().previewDevice("iPhone X")
    }
}

struct ImageView: View {
    @Binding var image: Image?
    @Binding var selected: Bool
    @Binding var showResult: Bool
    @Binding var name: String
    @Binding var confidence: String
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(selected ? Color.clear : Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                .frame(width:350, height: 350)
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .offset(y: 23)
                .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
            
            
            if image != nil {
                
                ZStack {
                    image?
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:350, height: 350)
                        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                        .offset(y: -30)
                        .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                    
                    Text("It is \(self.confidence) a \(self.name)!")
                        .foregroundColor(Color.white)
                        .frame(width: 350, height: 350)
                        .background(Color.black.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                        .opacity(self.showResult ? 1 : 0)
                        .offset(y: -30)
                        .animation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0))
                    
                    VStack {
                        HStack() {
                            Spacer()
                            Image(systemName: "xmark")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white)
                                .frame(width: 36, height: 36)
                                .background(Color.black.opacity(0.6))
                                .clipShape(Circle())
                                .opacity(selected ? 1 : 0)
                                .onTapGesture {
                                    self.selected = false
                                    self.showResult = false
                                    self.image = nil
                            }
                        }
                        Spacer()
                    }
                    .padding(.top, 40)
                    .padding(.trailing, 30)
                }
            }
            
            Text("Select a picture")
                .foregroundColor(.white)
                .offset(y: 23)
                .opacity(selected ? 0 : 1)
            
            
        }
    }
}
