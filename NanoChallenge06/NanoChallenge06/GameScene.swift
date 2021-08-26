//
//  GameScene.swift
//  NanoChallenge06
//
//  Created by IgorMiyamoto on 23/08/21.
//

import SpriteKit
import GameplayKit
import UIKit

protocol NotificationDelegate {
    func scheduleNotification()
    func showInstantNotification(title: String, body: String)
}

class GameScene: SKScene {
    
    private var progressBar: ProgressBar?
    var constant: SKLabelNode!
    var qtd: Int = 0
    var cups: SKLabelNode!
    var drinked: Int = 0
    var hp: CGFloat = 0
    var maxHp: CGFloat = 80
    var parabens: SKLabelNode!
    var completo: SKLabelNode!
    private var atualMaxWidth : CGFloat = 0
    var notificationDelegate : NotificationDelegate?
   
    
    override func didMove(to view: SKView) {
        progressBar = ProgressBar()
        progressBar?.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - 200)
        addChild(progressBar!)
        
        let mainLabel = SKLabelNode(text: "Hidratação do dia")
        mainLabel.fontName = "BalsamiqSans-Regular"
        mainLabel.fontSize = 36
        mainLabel.fontColor = .blue
        mainLabel.position = CGPoint(x: self.frame.midX - 90, y: (progressBar?.bar.position.y)! + 530)
        addChild(mainLabel)
        
        constant = SKLabelNode(text: "0ml")
        constant.fontColor = .white
        constant.fontName = "PatrickHand-Regular"
        constant.fontSize = 30
        constant.zPosition = 11
        constant.position.x = (progressBar?.bar.position.x)! + 10
        constant.position.y = (progressBar?.bar.position.y)! + 385
        addChild(constant)
        
        progressBar?.updateProgresso(hp/maxHp)
        
        //UIColor(red: 20, green: 17, blue: 163, alpha: 1)
        parabens = SKLabelNode(text: "Parabéns!")
        parabens.fontName = "BalsamiqSans-Regular"
        parabens.fontColor = .blue
        parabens.fontSize = 40
        parabens.position = CGPoint(x: frame.midX, y: constant.position.y - 45)
        
        completo = SKLabelNode(text: "Você tomou o recomendado de 2 litros de água por dia. Continue assim! (e não esqueça do seu amigo coelho)")
        completo.fontName = "PatrickHand-Regular"
        completo.fontSize = 31
        completo.fontColor = UIColor(red: 20, green: 17, blue: 163, alpha: 1)
        completo.position = CGPoint(x: frame.midX, y: parabens.position.y - 80)
        completo.numberOfLines = -1
        completo.preferredMaxLayoutWidth = 450
        completo.verticalAlignmentMode = .center
        
        let waterUp = WaterButton(image: SKSpriteNode(imageNamed: "waterbtn")){
            self.hp += 10
            self.progressBar?.updateProgresso(self.hp/self.maxHp)
            if self.qtd < 750{
                self.qtd += 250
                self.drinked += 1
                self.cups.text = "\(self.drinked)/8 copos"
                self.constant.text = "\(self.qtd)ml"
                self.constant.position.x = (self.progressBar?.bar.frame.maxX)! + 55
            } else if self.qtd != 2000{
                self.qtd += 250
                self.drinked += 1
                self.cups.text = "\(self.drinked)/8 copos"
                switch self.qtd {
                case 1000:
                    self.constant.text = "1L"
                case 1250:
                    self.constant.text = "1,25L"
                case 1500:
                    self.constant.text = "1,5L"
                case 1750:
                    self.constant.text = "1,75L"
                case 2000:
                    self.constant.text = "2L"
                    self.addChild(self.parabens)
                    self.addChild(self.completo)
                default:
                    break
                }
                self.constant.position.x = (self.progressBar?.bar.frame.maxX)! + 55
            }
        }
        
        waterUp.position = CGPoint(x: self.frame.midX, y: self.frame.minY + 200)
        waterUp.zPosition = 5
        self.addChild(waterUp)
        
        cups = SKLabelNode(text: "\(drinked)/8 copos")
        cups.fontColor = .white
        cups.fontName = "PatrickHand-Regular"
        cups.fontSize = 30
        cups.position = CGPoint(x: self.frame.midX, y: waterUp.position.y - 100)
        addChild(cups)
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    private func checkWatermeter() {
        self.notificationDelegate?.showInstantNotification(title: "Toma agua", body: "Agua")
    }
    
    
}
