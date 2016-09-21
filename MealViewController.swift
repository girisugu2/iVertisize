

import UIKit

import Photos /*  to get metadata of image */

/* For Apple Map */
//import CoreLocation
//import MapKit
/* For Google maps */
import GoogleMaps

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate {
    // MARK: Properties
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var showLocation: UIButton!
   
    var la:Double = 0.0
    var lo:Double = 0.0
    /*
        This value is either passed by `MealTableViewController` in `prepareForSegue(_:sender:)`
        or constructed as part of adding a new meal.
    */
    var meal: Meal?
    
    var gps: gpsData?
    struct globalVar
    {
        static var GPSLAT: Double = 12.2867
        static var GPSLON: Double = 77.3813
    }
    
    // 8/5/2016
    
    var locationManager = CLLocationManager()
    var currentLocation = CLPlacemark?()
    var detectLocation = CLLocationManager?()
    var locManager = CLLocationManager()
    
    // 8/5/2016
    
    var mapViews: GMSMapView?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field’s user input through delegate callbacks.
        nameTextField.delegate = self
 
        if let meal = meal {
            navigationItem.title = meal.name
            print("aaaa")
            nameTextField.text   = meal.name
     //       print("name is \(meal.name)")
            photoImageView.image = meal.photo
           ratingControl.rating = meal.rating
            print("GPS is \(meal.gpslati)")
            la = meal.gpslati
            print("La is \(la)")
            lo = meal.gpslongi
        }

        
   //     if let gps = gps
  //      {
            print("fronz")
  //         globalVar.GPSLAT = gps.gpsLat
   //         globalVar.GPSLON = gps.gpsLon
   //     print(gps.gpsLat)
    //    }
        
        // Enable the Save button only if the text field has a valid Meal name.
        checkValidMealName()
 
    }
   
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidMealName()
        navigationItem.title = textField.text
    }

    func textFieldDidBeginEditing(textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.enabled = false
    }
    
    func checkValidMealName() {
        // Disable the Save button if the text field is empty.
        let text = nameTextField.text ?? ""
        saveButton.enabled = !text.isEmpty
    }
    
    

    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismissViewControllerAnimated(true, completion: nil)
    }
    

    
    
//    var nextLevel:Double = 1.0
 //   let defaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
  
        // The info dictionary contains multiple representations of the image, and this uses the original.
     
       let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        
        // Developed on 9-8-2016 to get image properties
        
     
    
        
         if picker.sourceType == UIImagePickerControllerSourceType.PhotoLibrary
        {
       
            let assetURL = info[UIImagePickerControllerReferenceURL] as! NSURL
            let asset = PHAsset.fetchAssetsWithALAssetURLs([assetURL], options: nil)
            guard let result = asset.firstObject where result is PHAsset else {
        
            return
        }
        
            
        let imageManager = PHImageManager.defaultManager()
            imageManager.requestImageDataForAsset(result as! PHAsset, options: nil, resultHandler:{
                (data, responseString, imageOriet, info) -> Void in
           
                let imageData: NSData = data!
           
                    if let imageSource = CGImageSourceCreateWithData(imageData, nil) {
            
                        let imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, nil)! as NSDictionary
            
                        _ = imageProperties[kCGImagePropertyGPSDictionary as String]
      
                            if let gps = imageProperties.objectForKey(kCGImagePropertyGPSDictionary) as? NSDictionary {
                            
                                let latitudes = (gps["Latitude"] as! NSNumber).doubleValue;
                    
                                _ = gps["LatitudeRef"] as! String;
                   
                            
                       //         globalVar.GPSLAT = latitudes
                               self.la = latitudes
                            
                        //   latitudes = self.gpss!.gpsLat
                        //        self.gpss?.gpsLat = latitudes
                        //        print(self.gpss?.gpsLat)
                                //   self.gpss?.gpsLat = latitudes
                    
                                //        let gpss = self.gpss
                            
                                //        gpss!.gpsLat = latitudes
                            
                            
                                if let gpslon = imageProperties.objectForKey(kCGImagePropertyGPSDictionary) as? NSDictionary {
                                    
                                    let longitudes = (gpslon["Longitude"] as! NSNumber).doubleValue;
                    
                                    _ = gpslon["LongitudeRef"] as! String
                        
                         //         globalVar.GPSLON = longitudes
                                    self.lo = longitudes
                               //     longitudes = (self.gpss?.gpsLon)!
                                    
                                    
                      //              self.gpss?.gpsLon = longitudes
                                    //       let gpss1 = self.gpss
                            
                                    //       gpss1!.gpsLon = self.GPSLON
                            
                            
                                }
                    
                        }
                
                
                    }
            
        
                })
 
            }
  //      self.defaults.setDouble(self.GPSLAT, forKey: "NSUSR")
        
    photoImageView.image = selectedImage
        // Dismiss the picker.
    dismissViewControllerAnimated(true, completion: nil)
        
 }
    
    // MARK: Navigation
    
    func cancel(sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            navigationController!.popViewControllerAnimated(true)
        }
    }
     
 
    @IBAction func showLocation(sender: AnyObject) {
   /*
        print("Button Clicked")
        var gpsView1 = self.storyboard?.instantiateViewControllerWithIdentifier("gpsView") as! gpsView
        
     let gplat1 = meal?.gpslati
    
    //    self.navigationController?.pushViewController(gpsView, animated: true)
        gpsView1.ll = gplat1
        
  
   //     gpsView1.ll = (meal?.gpslati)!*/
        
    }
    
    
    // This method lets you configure a view controller before it's presented.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
        
    
        if segue.identifier == "gpsView"
            
        {
            
    //        let gpsView1 = self.storyboard?.instantiateViewControllerWithIdentifier("gpsView") as! gpsView
      let gpsView1 = segue.destinationViewController as! gpsView
            print("Hai")
            let gpslatitude = meal?.gpslati
            let gpslongitude = meal?.gpslongi
            
            gpsView1.ll = gpslatitude
            gpsView1.lo = gpslongitude
       
            
        }
 
    
        if saveButton === sender {

            let name = nameTextField.text ?? ""
            let photo = photoImageView.image
            let rating = ratingControl.rating
            
            print("LAA is \(la)")
  
            // Set the meal to be passed to MealListTableViewController after the unwind segue.
     //       let gpsLat = meal?.gpslati
           
            
 //           let gpsLon = meal?.gpslongi
            meal = Meal(name: name, photo: photo, rating: rating, gpslati: la, gpslongi: lo)
         
            }
        
       
    }
    
    // MARK: Actions
    
    
    func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
        // Hide the keyboard.
        nameTextField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerControllers = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerControllers.sourceType = .PhotoLibrary  //Select image from gallery
//       imagePickerControllers.sourceType = .Camera  //Select image from camera
        // Make sure ViewController is notified when the user picks an image.
        imagePickerControllers.delegate = self
     
        presentViewController(imagePickerControllers, animated: true, completion: nil)
    
        
    }
   
    
    

     func pp(sender: AnyObject) {
     
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            let imagePickerr = UIImagePickerController()
            imagePickerr.delegate = self
            imagePickerr.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
            imagePickerr.allowsEditing = true
            
            self.presentViewController(imagePickerr, animated: true, completion: nil)
            }
       
        
        }
    

    
}

