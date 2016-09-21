//
//  MealTableViewController.swift
//  FoodTracker



import UIKit

class MealTableViewController: UITableViewController {
    // MARK: Properties
    
    var meals = [Meal]()
//    var gpsfulldata = [gpsData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("uuuu")
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem()
        
        // Load any saved meals, otherwise load sample data.
        if let savedMeals = loadMeals() {
           
            meals += savedMeals
             print("meals")
        } else {
            // Load the sample data.
            loadSampleMeals()
        }
    }
    
    func loadSampleMeals() {
        let photo1 = UIImage(named: "meal1")!
        let meal1 = Meal(name: "Caprese Salad", photo: photo1, rating: 4, gpslati: 0.0, gpslongi: 1.1)!
        
        
        let photo2 = UIImage(named: "meal2")!
        let meal2 = Meal(name: "Chicken and Potatoes", photo: photo2, rating: 5, gpslati: 2.2, gpslongi: 3.3)!
        
        let photo3 = UIImage(named: "meal3")!
        let meal3 = Meal(name: "Pasta with Meatballs", photo: photo3, rating: 3, gpslati: 4.4, gpslongi: 5.5)!
        
        
        meals += [meal1, meal2, meal3]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     //   print("Meal Count \(meals.count)")
        return meals.count
 //   return 2
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "MealTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MealTableViewCell
        
        // Fetches the appropriate meal for the data source layout.
        let meal = meals[indexPath.row]
        
 //       let gps = gpsfulldata[indexPath.row]
        
        
        cell.nameLabel.text = meal.name
        cell.photoImageView.image = meal.photo
        cell.ratingControl.rating = meal.rating
        
        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        // Return false if you do not want the specified item to be editable.
        return true
  //  return false
    }
    

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {

        if editingStyle == .Delete {
            // Delete the row from the data source
            meals.removeAtIndex(indexPath.row)
           saveMeals()
           tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let mealDetailViewController = segue.destinationViewController as! MealViewController
            print("zzzz")
            // Get the cell that generated this segue.
            if let selectedMealCell = sender as? MealTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedMealCell)!
                let selectedMeal = meals[indexPath.row]
                mealDetailViewController.meal = selectedMeal
            }
        }
/*
        else if segue.identifier == "gpsView"
        {
            print("segue gpsView")
          let gpsDetailViewController = segue.destinationViewController as! gpsView
            
            if let selectedgps = sender as? MealTableViewCell
            {
                let index = tableView.indexPathForCell(selectedgps)
                let select = meals[index!.row]
                gpsDetailViewController.meal = select
            }
        }
        else if segue.identifier == "AddItem" {
                       print("Adding new meal.")
        }
*/
        //Show Map
  /*
        if segue.identifier == "gpsView"
        {
            let gpsDetailViewController = segue.destinationViewController as! gpsView
            
            if let selectedGPSCell = sender as? MealTableViewCell {
                let indexPathGPS = tableView.indexPathForCell(selectedGPSCell)!
                let selectedGPS = gpsfulldata[indexPathGPS.row]
                gpsDetailViewController.gps = selectedGPS
            }
        }
  */
     
    }
    
    
    

    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? MealViewController, meal = sourceViewController.meal {
            print("xxxx")
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing meal.
                meals[selectedIndexPath.row] = meal
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            } else {
                // Add a new meal.
            print("yyyy")
                let newIndexPath = NSIndexPath(forRow: meals.count, inSection: 0)
                 print("yyyy1")
                meals.append(meal)
                 print("yyyy")
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
           saveMeals()
        }
    /*        if let sourceViewControllerGPS = sender.sourceViewController as? gpsView, gps = sourceViewControllerGPS.gps {
                print("xyza")
                if let selectedIndexPathGPS = tableView.indexPathForSelectedRow {
                    // Update an existing meal.
                    gpsfulldata[selectedIndexPathGPS.row] = gps
                    tableView.reloadRowsAtIndexPaths([selectedIndexPathGPS], withRowAnimation: .None)
                } else {
                    // Add a new meal.
                    print("zabc")
                    let newIndexPathGPS = NSIndexPath(forRow: gpsfulldata.count, inSection: 0)
                    gpsfulldata.append(gps)
                    tableView.insertRowsAtIndexPaths([newIndexPathGPS], withRowAnimation: .Bottom)
                }
               // Save the meals.
            
   //         savedGPS()
        
        }*/
    }
    
    // MARK: NSCoding
    
    func saveMeals() {
        print("save meals")
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(meals, toFile: Meal.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save meals...")
        }
    }
    
 /*
    func loadGPS() -> [gpsData]? {
        print("Load GPS")
        return NSKeyedUnarchiver.unarchiveObjectWithFile(gpsData.url.path!) as? [gpsData]
    }
   */
    
    
    func loadMeals() -> [Meal]? {
        print("Load Meals")
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Meal.ArchiveURL.path!) as? [Meal]
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
}
