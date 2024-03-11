//
//  SceneDelegate.swift
//  Pokemon
//
//  Created by Bedri Keskin on 16.01.2024.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        if let windowScene = scene as? UIWindowScene {

            let window = UIWindow(windowScene: windowScene)
            let mainViewController = MainViewController(nibName: "MainViewController", bundle: nil)
            mainViewController.title = "Pokémon"
            let navigationController = UINavigationController(rootViewController: mainViewController)
            navigationController.navigationBar.backgroundColor = UIColor(red: 88/255, green: 86/255, blue: 206/255, alpha: 1)
            window.rootViewController = navigationController
            self.window = window
            window.makeKeyAndVisible()

            let height = (navigationController.navigationBar.frame.size.height)
            let width = (navigationController.navigationBar.frame.size.width)

            let button = UIButton(frame: CGRect(x: width-width/5, y: 0, width: width/5, height: height))
            button.backgroundColor = .red
            button.tintColor = .white
            button.setTitle("SwiftUI", for: .normal)
            button.addTarget(self, action: #selector(change(_:)), for: .touchUpInside)
            navigationController.navigationBar.addSubview(button)
        }
    }

    @objc func change(_ sender: UIButton) {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }

            let vc = UIHostingController(rootView: ContentView())
            vc.modalPresentationStyle = .fullScreen

            strongSelf.window?.rootViewController?.present(vc, animated: true, completion: nil)
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
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

