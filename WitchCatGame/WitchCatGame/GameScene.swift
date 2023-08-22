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

class GameScene: SCNScene, SCNPhysicsContactDelegate, ObservableObject {
    
    var cat = SCNNode()
    
    var enemyTimer = Timer()
    @Published var gameIsOver = false
    
    enum bitMasks: Int {
        case cat = 1
        case enemy = 2
    }
    
    convenience init(make: Bool) {
        self.init()
        
        background.contents = UIColor.blue //배경컬러 나중에 바꾸기
        physicsWorld.gravity = SCNVector3(x: 0, y: -5, z: 0)
        physicsWorld.contactDelegate = self
        
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
        cat.physicsBody?.categoryBitMask = bitMasks.cat.rawValue
        cat.physicsBody?.contactTestBitMask = bitMasks.enemy.rawValue
        cat.physicsBody?.collisionBitMask = bitMasks.enemy.rawValue
        
        rootNode.addChildNode(cat)
    }
    
    @objc func makeEnemy() {
        let randomNumber = Float.random(in: -4...5)
        
        let scene = SCNScene(named: "3D_GameScene.scn")!
        let enemyCrow = scene.rootNode.childNode(withName: "Crow", recursively: true)!
        enemyCrow.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        enemyCrow.physicsBody?.isAffectedByGravity = false
        enemyCrow.physicsBody?.categoryBitMask = bitMasks.enemy.rawValue
        enemyCrow.physicsBody?.contactTestBitMask = bitMasks.cat.rawValue
        enemyCrow.physicsBody?.collisionBitMask = bitMasks.cat.rawValue
        
        enemyCrow.position = SCNVector3(x: 20, y: randomNumber, z: 0)
        
        let moveAction = SCNAction.move(to: SCNVector3(x: -25, y: randomNumber, z: 0), duration: 5)
        
        enemyCrow.runAction(moveAction)
        rootNode.addChildNode(enemyCrow)
    }
    
    func physicsWorld(_ world: SCNPhysicsWorld, didEnd contact: SCNPhysicsContact) {
        let contactA: SCNPhysicsBody
        let contactB: SCNPhysicsBody
        
        if contact.nodeA.physicsBody!.categoryBitMask < contact.nodeB.physicsBody!.categoryBitMask {
            contactA = contact.nodeA.physicsBody!
            contactB = contact.nodeB.physicsBody!
        } else {
            contactA = contact.nodeB.physicsBody!
            contactB = contact.nodeA.physicsBody!
        }
        
        if contactA.categoryBitMask == bitMasks.cat.rawValue && contactB.categoryBitMask == bitMasks.enemy.rawValue {
            
            gameOver()
            enemyTimer.invalidate()
        }
    }
    
    func gameOver() {
        
        DispatchQueue.main.async {
            self.gameIsOver = true
        }
        
        let scene = SCNScene(named: "3D_GameScene.scn")!
        let gameOverText = scene.rootNode.childNode(withName: "OverText", recursively: true)!
        
        removeAllParticleSystems()
        rootNode.enumerateChildNodes { (node, stop) in
            node.removeFromParentNode()
        }
        rootNode.addChildNode(gameOverText)
    }
}
