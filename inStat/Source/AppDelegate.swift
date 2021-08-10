//
//  AppDelegate.swift
//  inStat
//
//  Created by Владислав Галкин on 09.08.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //По хорошему добавить assembly и router
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let view = ViewController()
        let networkService = NetworkService()
        let presenter = MainPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        let navigationController = UINavigationController(rootViewController: view)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}

