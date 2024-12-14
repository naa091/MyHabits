//
//  SceneDelegate.swift
//  MyHabits
//
//  Created by Александр Нистратов on 14.12.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let myWindow = UIWindow(windowScene: windowScene)
        self.window = myWindow
        
        let vc = ViewController()
        let nc = UINavigationController(rootViewController: vc)
        
        myWindow.rootViewController = nc
        myWindow.makeKeyAndVisible()
    }
}

