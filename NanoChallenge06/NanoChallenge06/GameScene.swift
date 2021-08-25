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
    
    private var progressBar: ProgressBar?
    var constant: SKLabelNode!
    var qtd: Int = 0
    var cups: SKLabelNode!
    var drinked: Int = 0
    var hp: CGFloat = 0
    var maxHp: CGFloat = 80
    private var barraTotal : SKSpriteNode!
    private var barraAtual : SKSpriteNode!
    private var atualMaxWidth : CGFloat = 0
    var notificationDelegate : NotificationDelegate?
   
    
    override func didMove(to view: SKView) {
        progressBar = ProgressBar()
        progressBar?.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - 200)
        addChild(progressBar!)
        
        let mainLabel = SKLabelNode(text: "Hidratação do dia")
        mainLabel.fontName = "BalsamiqSans-Regular"
        mainLabel.fontSize = 36
        mainLabel.fontColor = UIColor(red: 20, green: 17, blue: 163, alpha: 1)
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
//
//        let full = SKLabelNode(text: "2L")
//        full.fontColor = .cyan
//        full.fontName = "PatrickHand-Regular"
//        full.fontSize = 50
//        full.zPosition = 9
//        full.position = CGPoint(x: (progressBar?.border.position.x)! + 210, y: (progressBar?.border.position.y)! + 450)
//        //addChild(full)
//
        progressBar?.updateProgresso(hp/maxHp)
        
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
                default:
                    break
                }
                self.constant.position.x = (self.progressBar?.bar.frame.maxX)! + 55
            }
        }
        
        waterUp.position = CGPoint(x: self.frame.midX, y: self.frame.minY + 300)
        waterUp.zPosition = 5
        self.addChild(waterUp)
        
        cups = SKLabelNode(text: "\(drinked)/8 copos")
        cups.fontColor = .white
        cups.fontName = "PatrickHand-Regular"
        cups.fontSize = 30
        cups.position = CGPoint(x: self.frame.midX, y: waterUp.position.y - 100)
        addChild(cups)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    private func checkWatermeter() {
        self.notificationDelegate?.showInstantNotification(title: "Toma agua", body: "Agua")
    }
    
    
}
