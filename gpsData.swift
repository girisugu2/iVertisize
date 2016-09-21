//
//  gpsData.swift
//  FoodTracker
//
//  Created by iVertisize on 8/29/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit


class gpsData: NSObject , NSCoding
{

    //MARK: Properties
    var gpsLat: Double
    var gpsLon: Double
    
    // MARK: Archiving Paths
    static let manager = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let url = manager.URLByAppendingPathComponent("gpsfulldata")
 
    //MARK: Types
    
    struct Keys {
        
        static let latKey = "latitude"
        static let lonKey = "longitude"
    
    }
 
    //MARK: Initializations
    
    init(gpsLat: Double, gpsLon: Double) {
        
        self.gpsLat = gpsLat
   //     print("gpsData.swift gpsLat \(gpsLat)")
        self.gpsLon = gpsLon
     //   print("GPS is \(gpsLat)")
        
        super.init()
        }
    
    //MARK: NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeDouble(gpsLat, forKey: Keys.latKey)
        aCoder.encodeDouble(gpsLon, forKey: Keys.lonKey)
        
        
    }
 
    
    required convenience init?(coder aDecoder: NSCoder) {
        let gpsLat = aDecoder.decodeDoubleForKey(Keys.latKey) 
        let gpsLon = aDecoder.decodeDoubleForKey(Keys.lonKey) 

        
        // Must call designated initializer.
        self.init(gpsLat: gpsLat, gpsLon: gpsLon)
    }
    


}