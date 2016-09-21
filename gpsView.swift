//
//  gps.swift
//  FoodTracker
//
//  Created by iVertisize on 8/22/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps

class gpsView: UIViewController
{

    var meal: Meal?
    
    var ll:Double?
    var lo:Double?
    
    override func viewDidLoad() {
     
        let iop = ll
        let poi = lo
        print(iop)
        print(poi)

        
        let camera = GMSCameraPosition.cameraWithLatitude(iop!, longitude: poi!, zoom: 16)
        let mapView = GMSMapView.mapWithFrame(CGRect.zero, camera: camera)
        mapView.myLocationEnabled = true
        view = mapView
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: iop!, longitude: poi!)
        marker.map = mapView
  //   print("hai your string value from viewcontroller is \(stringval)")
        
   //     gpsfulldata = (NSKeyedUnarchiver.unarchiveObjectWithFile(gpsData.url.path!) as? [gpsData])!
        
  //      print(gpsfulldata.count)
   //     super.viewDidLoad()
     /*
         let gps1 = gps
        
            let co_lat = gps1!.gpsLat
            var co_lon = gps1!.gpsLon
*/
  //    print("CO_LAT  \(co_lat)")
        
        
 //    print("Welcome")
        
   //     print(data1)
        
    //    print(data2)
        
       
    //   savedGPS()
        /*
        
        if let savedGPS = loadGPS() {
            gpsfulldata += savedGPS
        }
      */
    
      
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        
 //       marker.title = "India"  
//        marker.snippet = "Bangalore"
 //       marker.map = mapView
        
      
    }
  /*
    func savedGPS()
    {
        print("SAVE gps")
        
        let saveGPS =  NSKeyedArchiver.archiveRootObject(gpsfulldata, toFile: gpsData.url.path!)
        if !saveGPS
        {
            print("Failed to saveGPS")
        }
        
    }
    */
    
    func loadSampleGPS()
    {
        let camera = GMSCameraPosition.cameraWithLatitude(13.023534, longitude: 77.635071, zoom: 16)
        let mapView = GMSMapView.mapWithFrame(CGRect.zero, camera: camera)
        mapView.myLocationEnabled = true
        view = mapView
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 13.023534, longitude: 77.635071)
        marker.map = mapView
        
    }
    
    
 
    
    
    
    
}
