//
//  ContentView.swift
//  WitchCatGame
//
//  Created by 김미지 on 2023/08/23.
//

import SwiftUI
import SceneKit

struct ContentView: View {
   
    @StateObject var scene = GameScene(make: true)
    
    var body: some View {
        NavigationView {
            
            ZStack {
                SceneView(scene:scene, options: .autoenablesDefaultLighting)
                    .ignoresSafeArea()
                    .onTapGesture {
                        scene.cat.physicsBody?.velocity.y = 3
                    }
                
                if scene.gameIsOver == true {
                    NavigationLink {
                        StartView()
                    } label: {
                        VStack {
                            
                            Spacer()
                                .frame(height: 150)
                            
                            Text("Back")
                                .font(.system(size: 53, design: .rounded))
                                .font(.title)
                                .foregroundColor(.red)
                                .frame(width: 600, height: 50)
                                .background(.white)
                                .clipShape(Capsule())
                            
                        }
                    }
                
                }
            
            }
        }
        .navigationViewStyle(.stack)
        .navigationBarBackButtonHidden(true)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
