//
//  GameScene.swift
//  NanoChallenge06
//
//  Created by IgorMiyamoto on 23/08/21.
//

import SpriteKit
import GameplayKit

protocol NotificationDelegate {
    func scheduleNotification()
    func showInstantNotification(title: String, body: String)
}

class GameScene: SKScene {
    
    private var barraTotal : SKSpriteNode!
    private var barraAtual : SKSpriteNode!
    private var atualMaxWidth : CGFloat = 0
    var notificationDelegate : NotificationDelegate?
    
    override func didMove(to view: SKView) {
        barraTotal = SKSpriteNode(color: .white, size: CGSize(width: self.frame.width - 200, height: 100))
        atualMaxWidth = barraTotal.frame.width - 50
        barraAtual = SKSpriteNode(color: .blue, size: CGSize(width: barraTotal.frame.width - 50, height: 50))
        
        barraTotal.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - 150)
        barraTotal.zPosition = 0
        self.addChild(barraTotal)
        barraAtual.position = barraTotal.position
        barraAtual.zPosition = 1
        self.addChild(barraAtual)
        
        self.notificationDelegate?.showInstantNotification(title: "Toma agua", body: "Agua")
    }
    
    override func update(_ currentTime: TimeInterval) {
//        if barraAtual.frame.width > 100 {
//            barraAtual.run(SKAction.resize(toWidth: barraAtual.frame.width - (atualMaxWidth * 0.05), duration: 1))
//        }
//        else {
//            checkWatermeter()
//        }
    }
    
    private func checkWatermeter() {
        self.notificationDelegate?.showInstantNotification(title: "Toma agua", body: "Agua")
    }
}
