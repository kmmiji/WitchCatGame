//
//  GameScene.swift
//  WitchCatGame
//
//  Created by 김미지 on 2023/08/23.
//

import Foundation
import SceneKit
import QuartzCore
import UIKit

class GameScene: SCNScene {
    
    var cat = SCNNode()
    
    var enemyTimer = Timer()
    
    convenience init(make: Bool) {
        self.init()
        
        background.contents = UIColor.blue //배경컬러 나중에 바꾸기
        physicsWorld.gravity = SCNVector3(x: 0, y: -5, z: 0)
        
        let scene = SCNScene(named: "3D_GameScene.scn")!
        let cam = scene.rootNode.childNode(withName: "camera", recursively: true)!
        let particel = scene.rootNode.childNode(withName: "particles", recursively: true)!
        
        rootNode.addChildNode(cam)
        rootNode.addChildNode(particel)
        
        enemyTimer = .scheduledTimer(timeInterval: 2, target: self, selector: #selector(makeEnemy), userInfo: nil, repeats: true)
        
        witchCat()
    }
    
    func witchCat() {
        let scene = SCNScene(named: "3D_GameScene.scn")!
        cat = scene.rootNode.childNode(withName: "WitchCat", recursively: true)!
        cat.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        
        rootNode.addChildNode(cat)
    }
    
    @objc func makeEnemy() {
        let randomNumber = Float.random(in: -4...4)
        
        let scene = SCNScene(named: "3D_GameScene.scn")!
        let enemyCrow = scene.rootNode.childNode(withName: "Crow", recursively: true)!
        
        enemyCrow.position = SCNVector3(x: 20, y: randomNumber, z: 0)
        
        let moveAction = SCNAction.move(to: SCNVector3(x: -15, y: randomNumber, z: 0), duration: 6)
        
        enemyCrow.runAction(moveAction)
        rootNode.addChildNode(enemyCrow)
    }
}
