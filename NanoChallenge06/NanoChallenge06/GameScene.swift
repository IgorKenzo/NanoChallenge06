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
    var constText: String = "0ml"
    var qtd: Int = 0
    var cups: SKLabelNode!
    var drinked: Int = 0
    var hp: CGFloat = 0
    var maxHp: CGFloat = 80
    var parabens: SKLabelNode!
    var completo: SKLabelNode!
    private var atualMaxWidth : CGFloat = 0

    private var feliz : [SKTexture] = []
    private var parado : [SKTexture] = []
    private var murcho : [SKTexture] = []
    private var murchando : [SKTexture] = []
    private var agua : [SKTexture] = []
    private var sprite : SKSpriteNode!
    
    
    override func didMove(to view: SKView) {
        
        qtd = UserDefaults.standard.integer(forKey: "qtd")
        drinked = UserDefaults.standard.integer(forKey: "drinked")
        hp = CGFloat(UserDefaults.standard.float(forKey: "hp"))
        constText = UserDefaults.standard.string(forKey: "constText") ?? "0ml"
        
        feliz = importAtlas(name: "feliz")
        parado = importAtlas(name: "parado")
        murcho = importAtlas(name: "murcho")
        murchando = importAtlas(name: "murchando")
        agua = importAtlas(name: "agua")
        
        progressBar = ProgressBar()
        progressBar?.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - 200)
        addChild(progressBar!)
        
        let mainLabel = SKLabelNode(text: "Hidratação do dia")
        mainLabel.fontName = "BalsamiqSans-Regular"
        mainLabel.fontSize = 36
        mainLabel.fontColor = UIColor(named: "fonte")
        mainLabel.position = CGPoint(x: self.frame.midX - 90, y: (progressBar?.bar.position.y)! + 530)
        addChild(mainLabel)
        
        constant = SKLabelNode(text: constText)
        constant.fontColor = UIColor(named: "fonte")
        constant.fontName = "PatrickHand-Regular"
        constant.fontSize = 30
        constant.zPosition = 11
        constant.position.x = (UserDefaults.standard.float(forKey: "constPosX").isZero) ? (progressBar?.bar.position.x)! + 10 : CGFloat(UserDefaults.standard.float(forKey: "constPosX"))
        constant.position.y = (progressBar?.bar.position.y)! + 385
        addChild(constant)
        
        
        progressBar?.updateProgresso(hp/maxHp)
        
        parabens = SKLabelNode(fontNamed: "BalsamiqSans-Bold")
        parabens.text = "Parabéns"
        parabens.fontColor = UIColor(named: "fonte")
        parabens.fontSize = 40
        parabens.position = CGPoint(x: frame.midX, y: constant.position.y - 45)
        
        completo = SKLabelNode(text: "Você tomou o recomendado de 2 litros de água por dia. Continue assim! (e não esqueça do seu amigo coelho)")
        completo.fontName = "PatrickHand-Regular"
        completo.fontSize = 31
        completo.fontColor = UIColor(named: "fonte")
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
                self.constText = "\(self.qtd)ml"
                self.constant.text = self.constText
                self.constant.position.x += 55
            } else if self.qtd != 2000{
                self.qtd += 250
                self.drinked += 1
                self.cups.text = "\(self.drinked)/8 copos"
                switch self.qtd {
                case 1000:
                    self.constText = "1L"
                    self.constant.text = self.constText
                case 1250:
                    self.constText = "1,25L"
                    self.constant.text = self.constText
                case 1500:
                    self.constText = "1,5L"
                    self.constant.text = self.constText
                case 1750:
                    self.constText = "1,75L"
                    self.constant.text = self.constText
                case 2000:
                    self.constText = "2L"
                    self.constant.text = self.constText
                    self.addChild(self.parabens)
                    self.addChild(self.completo)
                default:
                    break
                }
                self.constant.position.x += 55
            }
            
            self.sprite.run(SKAction.animate(with: self.agua, timePerFrame: 0.1)){
                self.animateSprite(atlas: self.feliz)
            }
            
            UserDefaults.standard.setValue(self.qtd, forKey: "qtd")
            UserDefaults.standard.setValue(self.drinked, forKey: "drinked")
            UserDefaults.standard.setValue(Float(self.hp), forKey: "hp")
            UserDefaults.standard.setValue(self.constText, forKey: "constText")
            UserDefaults.standard.setValue(Float(self.constant.position.x), forKey: "constPosX")
            UserDefaults.standard.setValue(Date(), forKey: "lastOpen")
        }
        
        waterUp.position = CGPoint(x: self.frame.midX, y: self.frame.minY + 200)
        waterUp.zPosition = 5
        self.addChild(waterUp)
        
        cups = SKLabelNode(text: "\(drinked)/8 copos")
        cups.fontColor = UIColor(named: "fonte")
        cups.fontName = "PatrickHand-Regular"
        cups.fontSize = 30
        cups.position = CGPoint(x: self.frame.midX, y: waterUp.position.y - 100)
        addChild(cups)
        
        self.sprite = self.childNode(withName: "cueio") as? SKSpriteNode
        self.sprite.texture = feliz[0]

        let lastOpen = UserDefaults.standard.object(forKey: "lastOpen") as? Date
        let date = Date()

        if let lo = lastOpen {
            let diffComponents = Calendar.current.dateComponents([.hour], from: lo, to: date)
            let hours = diffComponents.hour

            if let h = hours {
                if h >= 2 {
                    animateSprite(atlas: murcho)
                } else {
                    animateSprite(atlas: parado)
                }
            }
        }else {
            UserDefaults.standard.setValue(date, forKey: "lastOpen")
            animateSprite(atlas: feliz)
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    private func importAtlas(name : String) -> [SKTexture]{
        let animatedAtlas = SKTextureAtlas(named: name)
        var frames: [SKTexture] = []
        
        for i in 1..<animatedAtlas.textureNames.count {
            frames.append(animatedAtlas.textureNamed("\(name)\(i)"))
        }
        return frames
    }
    
    
    
    func animateSprite(atlas: [SKTexture]) {
      sprite.run(SKAction.repeatForever(
        SKAction.animate(with: atlas,
                         timePerFrame: 0.1,
                         resize: false,
                         restore: true)),
        withKey:"animation")
    }
}
