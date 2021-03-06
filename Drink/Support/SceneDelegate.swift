//
//  SceneDelegate.swift
//  Drink
//
//  Created by Lonnie Gerol on 12/30/19.
//  Copyright © 2019 Lonnie Gerol. All rights reserved.
//

import UIKit
import SwiftUI
import AppAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        NetworkManager.shared.loadState()
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.windowScene = windowScene
            window.tintColor =  UIColor(red: 176/255, green: 25/255, blue: 126/255, alpha: 1.00)
            window.backgroundColor = UIColor(red: 176/255, green: 25/255, blue: 126/255, alpha: 1.00)
            let tabBarController = DKTabBarVC()
            tabBarController.viewControllers = [createRootNC(machineIdentifier: .bigDrink, machineIconName: "rectangle.fill"), createRootNC(machineIdentifier: .littleDrink, machineIconName: "hexagon.fill")]
            window.rootViewController = tabBarController
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
    func createRootNC(machineIdentifier: ExistingMachines, machineIconName: String) -> UINavigationController{
        let itemListVC = ItemsListVC(machineIdentifer: machineIdentifier)
        if machineIdentifier == .bigDrink{
            itemListVC.title = "Big Drink"
        }
        else{
            itemListVC.title = "Little Drink"
        }
        itemListVC.tabBarItem = UITabBarItem(title: itemListVC.title, image: UIImage(systemName: machineIconName), selectedImage: nil)
        return UINavigationController(rootViewController: itemListVC)
    }
    
   
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

