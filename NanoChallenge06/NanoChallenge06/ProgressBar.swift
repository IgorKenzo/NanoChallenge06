//
//  ProgressBar.swift
//  NanoChallenge06
//
//  Created by Sayuri Hioki on 24/08/21.
//

import Foundation
import SpriteKit

class ProgressBar: SKNode{
    var border: SKSpriteNode
    var bar: SKSpriteNode
    var layer: SKSpriteNode
    var qtd: Int = 0
    
    override init(){
        self.border = SKSpriteNode(imageNamed: "border")
        self.bar = SKSpriteNode(imageNamed: "bar")
        self.layer = SKSpriteNode(imageNamed: "layer")
        self.border.size = CGSize(width: 500, height: 70)
        self.bar.size = CGSize(width: 500, height: 70)
        self.layer.size = CGSize(width: 500, height: 90)
        super.init()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.border = SKSpriteNode(color: .lightGray, size: .init(width: 500, height: 70))
        self.bar = SKSpriteNode(color: .green, size: .init(width: 500, height: 70))
        self.layer = SKSpriteNode(color: .gray, size: .init(width: 500, height: 90))
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup(){
        border.zPosition = 1
        bar.zPosition = 10
        layer.zPosition = 11
        
        bar.anchorPoint = .init(x: 0, y: 0.5)
        bar.position.x = -(bar.size.width/2)
        
        addChild(border)
        addChild(bar)
        addChild(layer)
    }
    
    public func updateProgresso(_ qtd: CGFloat){
        let progress = min(max(0, qtd), 1)
        bar.run(.scaleX(to: progress, duration: 0.3))
    }
}
