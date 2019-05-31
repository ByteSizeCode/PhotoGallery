

import UIKit
import Material

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        window = UIWindow(frame: Screen.bounds)
        window!.rootViewController = AppToolbarController(rootViewController: PhotoCollectionViewController())
        window!.makeKeyAndVisible()
    }
}

