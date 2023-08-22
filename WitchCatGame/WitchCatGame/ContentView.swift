//
//  ContentView.swift
//  WitchCatGame
//
//  Created by 김미지 on 2023/08/23.
//

import SwiftUI
import SceneKit

struct ContentView: View {
    
    let scene = GameScene(make: true)
    
    var body: some View {
        SceneView(scene:scene, options: .autoenablesDefaultLighting)
            .ignoresSafeArea()
            .onTapGesture {
                scene.cat.physicsBody?.velocity.y = 4
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
