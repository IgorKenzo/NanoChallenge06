//
//  GameViewController.swift
//  NanoChallenge06
//
//  Created by IgorMiyamoto on 23/08/21.
//

import UIKit
import SpriteKit
import UserNotifications

class GameViewController: UIViewController, NotificationDelegate {
    
    let uncenter = UNUserNotificationCenter.current()
    
    
    func scheduleNotification() {
        
    }
    
    func showInstantNotification(title: String, body: String) {
        //Conteúdo da notificação
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        
        // Trigger
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        //Request
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        //Register
        uncenter.add(request) { err in
            if let e = err {
                print(e)
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Permissão para enviar notificações
        
        
        uncenter.requestAuthorization(options: [.alert,.sound]) { answer, error in
            if answer {
                print("Autorizado")
            } else {
                print("Não autorizado")
            }
            if let er = error {
                print(er)
            }
        }
        
//        //Conteúdo da notificação
//        let content = UNMutableNotificationContent()
//        content.title = "Notificação massa"
//        content.body = "Jaré 🐊"
//
//        // Trigger
//        let date = Date().addingTimeInterval(5)
//        let components = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
//
//        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
//
//        //Request
//        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//
//        //Register
//        uncenter.add(request) { err in
//            if let e = err {
//                print(e)
//            }
//        }
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") as? GameScene {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                scene.notificationDelegate = self
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
