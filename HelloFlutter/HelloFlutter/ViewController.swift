//
//  ViewController.swift
//  HelloFlutter
//
//  Created by Hasan Rafi on 10/14/20.
//

import UIKit
import Flutter

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Make a button to call the showFlutter function when pressed.
        let button = UIButton(type:UIButton.ButtonType.custom)
        button.addTarget(self, action: #selector(showFlutter), for: .touchUpInside)
        button.setTitle("Show Flutter!", for: UIControl.State.normal)
        button.frame = CGRect(x: 80.0, y: 210.0, width: 160.0, height: 40.0)
        button.backgroundColor = UIColor.blue
        self.view.addSubview(button)
    }

    @objc func showFlutter() {
        let flutterEngine = (UIApplication.shared.delegate as! AppDelegate).flutterEngine
        let flutterViewController = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
        
        let batteryChannel = FlutterMethodChannel(name: "samples.flutter.dev/battery", binaryMessenger: flutterViewController.binaryMessenger)
        batteryChannel.setMethodCallHandler({(call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            // Note: this method is invoked on the UI thread.
            // Handle battery messages.
            if call.method == "getBatteryLevel" {
                self.receiveBatteryLevel(result: result)
            }
        })
        
        present(flutterViewController, animated: true) {
            batteryChannel.invokeMethod("fromHostToClient", arguments: "Hello World")
        }
    }
    
    private func receiveBatteryLevel(result: FlutterResult) {
        let device = UIDevice.current
        device.isBatteryMonitoringEnabled = true
        
        if device.batteryState == UIDevice.BatteryState.unknown {
            result(53)
        } else {
            result(Int(device.batteryLevel * 100))
        }
    }
}

