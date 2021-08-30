//
//  GameViewController.swift
//  NanoChallenge06
//
//  Created by IgorMiyamoto on 23/08/21.
//

import UIKit
import SpriteKit
import UserNotifications

class GameViewController: UIViewController {
    
    let uncenter = UNUserNotificationCenter.current()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Permissão para enviar notificações
        uncenter.requestAuthorization(options: [.alert,.sound]) { answer, error in
            if answer {
                print("Autirizado")
            }
            else {
                print("Não autorizado")
            }
            if let er = error {
                print(er)
            }
        }
        createDailyNotifications()
//
//        //Conteudo notificao
//        let conteudo = UNMutableNotificationContent()
//        conteudo.title = "Notificação"
//        //conteudo.subtitle = ""
//        conteudo.body = "Minha notificação lala"
//
//        //trigger
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//
//        //Request
//        let request = UNNotificationRequest(identifier: UUID().uuidString, content: conteudo, trigger: trigger)
//
//        //Registrar o request
//        uncenter.add(request) { error in
//            if let er = error {
//                print(er)
//            }
//        }
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") as? GameScene {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
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
    
    
    //MARK: Schedule Daily notifications
    func scheduleDailyNotification(title: String, body: String, dateComponents: DateComponents, repeats: Bool) {

        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: repeats)

        let request = UNNotificationRequest(identifier: "Daily: " + UUID().uuidString, content: content, trigger: trigger)

        uncenter.add(request) { error in
            if let e = error {
                print("Error adding notification request: \(e)")
            }
        }
    }

    func createDailyNotifications() {
        let startingHour = 10 //Da pra trocar por uma info que o usuario coloca, tipo horario que acorda
        uncenter.removeAllPendingNotificationRequests()
        for i in 0..<8 {
            var dateComponents = DateComponents()
            dateComponents.calendar = Calendar.current
            dateComponents.hour = startingHour + (i * 2)

            scheduleDailyNotification(title: "Hidrata +", body: "É Hora de tomar água", dateComponents: dateComponents, repeats: true)
            print("Criada notificaçao: title: Hidrata +, body: É Hora de tomar água, dateComponents: \(dateComponents), repeats: true")
        }
    }
}
