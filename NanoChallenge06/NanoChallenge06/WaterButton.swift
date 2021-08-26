//
//  WaterButton.swift
//  NanoChallenge06
//
//  Created by Sayuri Hioki on 24/08/21.
//

import Foundation
import SpriteKit

class WaterButton: SKNode{
    
    var image: SKSpriteNode?
    var action: (() -> Void)?
    
    init(image: SKSpriteNode, action: @escaping () -> Void) {
        self.image = image
        self.action = action
        
        super.init()
        self.isUserInteractionEnabled = true
        
        self.addChild(image)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.action?()
    }
}
