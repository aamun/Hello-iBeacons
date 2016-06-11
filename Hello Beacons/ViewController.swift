//
//  ViewController.swift
//  Hello Beacons
//
//  Created by Aaron Munguia on 6/2/16.
//  Copyright © 2016 Aaron Munguia. All rights reserved.
//

import UIKit
import KontaktSDK

class ViewController: UIViewController {
    
    var beaconManager: KTKBeaconManager!
    var beacon:CLBeacon?
    let colors = [
        37515:UIColor.redColor(),
        51735:UIColor.yellowColor(),
        7541:UIColor.greenColor()
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Initiate Beacon Manager
        beaconManager = KTKBeaconManager(delegate: self)
        beaconManager.requestLocationAlwaysAuthorization()
        
        // Region
        let proximityUUID = NSUUID(UUIDString: "f7826da6-4fa2-4e98-8024-bc5b71e0893e")
        let region = KTKBeaconRegion(proximityUUID: proximityUUID!, identifier: "region")
        
        // Start Monitoring and Ranging
        beaconManager.startMonitoringForRegion(region)
        beaconManager.startRangingBeaconsInRegion(region)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

extension ViewController: KTKBeaconManagerDelegate {
    
    func beaconManager(manager: KTKBeaconManager, didChangeLocationAuthorizationStatus status: CLAuthorizationStatus) {
        
    }
    
    func beaconManager(manager: KTKBeaconManager, didEnterRegion region: KTKBeaconRegion) {
        print("Enter region \(region)")
    }
    
    func beaconManager(manager: KTKBeaconManager, didExitRegion region: KTKBeaconRegion) {
        print("Exit region \(region)")
    }
    
    func beaconManager(manager: KTKBeaconManager, didRangeBeacons beacons: [CLBeacon], inRegion region: KTKBeaconRegion) {
        
        for beacon in beacons {
            print("UUID: \(beacon.proximityUUID.UUIDString)")
            print("Proximity: \(beacon.proximity.hashValue)")
            print("Accuracy: \(beacon.accuracy)")
            print("RSSi: \(beacon.rssi)")
            print("Major: \(beacon.major)")
            print("Minor: \(beacon.minor)")
        }
        
        print("Ranged beacons count: \(beacons.count)")
        
        if beacons.count > 0 {
            view.backgroundColor = colors[(beacons.first?.minor.integerValue)!]
        }
    }
}