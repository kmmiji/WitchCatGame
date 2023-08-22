//
//  StartView.swift
//  WitchCatGame
//
//  Created by 김미지 on 2023/08/23.
//

import SwiftUI

struct StartView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.purple
                
                VStack {
                    Spacer()
                    
                    Text("Witch Cat Game")
                        .foregroundColor(.white)
                        .font(.system(size: 63, design: .rounded))
                        .bold()
                        .padding()
                    
                    Spacer()
                    
                    NavigationLink {
                        ContentView()
                    } label: {
                        Text("Start")
                            .font(.system(size: 30, design: .rounded))
                            .padding(20)
                            .background(.white)
                            .cornerRadius(15)
                    }
                    
                    Spacer()
                }
            }
            .ignoresSafeArea()
        }
        .navigationViewStyle(.stack)
        .navigationBarBackButtonHidden(true)
    }
}


struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
