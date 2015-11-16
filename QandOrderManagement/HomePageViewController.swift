//
//  HomePageViewController.swift
//  QandOrderManagement
//
//  Created by Pannray Samanphanchai on 11/6/2558 BE.
//  Copyright © 2558 Pannray Samanphanchai. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController, UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate  {

    @IBOutlet weak var scvPromotion : UIScrollView!
    @IBOutlet weak var pcPromotion : UIPageControl!
    @IBOutlet weak var tbvRestaurant: UITableView!
    
    var pointNow: CGPoint!
    var pageImages: [UIImage] = []
    var pageViews: [UIImageView?] = []
    var myTimer : NSTimer = NSTimer()
    var countTimer:Int = 0
    var selectedRestaurant : Int = 0
    
    var customFont = UIFont(name: "ravenna-serial-light-regular", size: 17.0)
    
    var promotionArray : [String] = ["SizzlerPromotion.jpg", "PizzaPromotion.jpg", "SwensenPromotion.jpg"]
    var restaurantArray : [String] = ["Sizzler", "The Pizza Company", "Swensen", "DQ", "Burger King"]
    override func viewDidLoad() {
        super.viewDidLoad()

        scvPromotion.frame.origin.x = 0
        scvPromotion.frame.origin.y = 80
        scvPromotion.frame.size.width = 320
        scvPromotion.frame.size.height = 190
        print("scvPromotion.frame: \(scvPromotion.frame)")
        
        //Get Promotion Image
        print("promotionController")
        
        
        for i in 0..<(promotionArray.count) {
            print(".... \(promotionArray[i])")
            pageImages.append(UIImage(named: promotionArray[i])!)
        }
        
        let pageCount = promotionArray.count
        
        // Set up the page control
        pcPromotion.currentPage = 0
        pcPromotion.numberOfPages = pageCount
        pcPromotion.backgroundColor = UIColor(white: 1, alpha: 0)
        // Set up the array to hold the views for each page
        for _ in 0..<pageCount {
            pageViews.append(nil)
        }
        print(">>> \(pageImages.count)")
        // Set up the content size of the scroll view
        let pagesScrollViewSize = scvPromotion.frame.size
        scvPromotion.contentSize = CGSizeMake(pagesScrollViewSize.width * CGFloat(pageImages.count), pagesScrollViewSize.height)
        
        // Load the initial set of pages that are on screen
        loadVisiblePages()
        //
//        setupTable()
        self.tbvRestaurant.delegate = self

        
        
        // Do any additional setup after loading the view.
    }

    //Start - Promotion
    func loadVisiblePages() {
        // First, determine which page is currently visible
        let pageWidth = scvPromotion.frame.size.width
        let page = Int(floor((scvPromotion.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0)))
        //print("page \(page)")
        // Update the page control
        pcPromotion.currentPage = page
        // Work out which pages you want to load
        let firstPage = page - 1
        let lastPage = page + 1
        // Purge anything before the first page
        for var index = 0; index < firstPage; ++index {
            purgePage(index)
        }
        // Load pages in our range
        for var index = 0; index < pageImages.count; ++index{
            loadPage(index)
        }
        
        // Purge anything after the last page
        for var index = lastPage+1; index < pageImages.count; ++index {
            purgePage(index)
        }
    }
    func purgePage(page: Int) {
        if page < 0 || page >= pageImages.count {
            // If it's outside the range of what you have to display, then do nothing
            return
        }
        // Remove a page from the scroll view and reset the container array
        if let pageView = pageViews[page] {
            pageView.removeFromSuperview()
            pageViews[page] = nil
        }
    }
    func loadPage(page: Int) {
        if page < 0 || page >= pageImages.count {
            // If it's outside the range of what you have to display, then do nothing
            return
        }
        //        // Load an individual page, first checking if you've already loaded it
        if let pageView = pageViews[page] {
            // Do nothing. The view is already loaded.
        } else {
            var frame = scvPromotion.bounds
            frame.origin.x = frame.size.width * CGFloat(page)
            frame.origin.y = 0.0
            //frame = CGRectInset(frame, 10.0, 0.0)
            let newPageView = UIImageView(image: pageImages[page])
            //newPageView.contentMode = .ScaleAspectFit
            newPageView.frame = frame
            //
            let btnPromotion = UIButton()
            //btnPromotion.setImage(pageImages[page],forState: .Normal)
            btnPromotion.titleLabel!.text = String(page)
            btnPromotion.titleLabel?.hidden = true
            btnPromotion.addTarget(self, action: "btnPromotionTapped:", forControlEvents: UIControlEvents.TouchUpInside)
            btnPromotion.frame = CGRectMake((frame.width * CGFloat(page)) , 0, frame.width, frame.height)
            //btnPromotion.frame = CGRectMake(0, 0, frame.width, frame.height)
            
            scvPromotion.addSubview(btnPromotion)
            scvPromotion.addSubview(newPageView)
            
            pageViews[page] = newPageView
        }
    }
    
    func btnPromotionTapped(sender:UIButton!){
        /*
        let vc = Detail2ViewController(nibName: "Detail2ViewController", bundle: nil)
        vc.id = "aa"
        navigationController?.pushViewController(vc, animated: true)
        */
        performSegueWithIdentifier("promotionSegue", sender: nil)
        print("BTN PromotionTapped \(pcPromotion.currentPage)")
        
//        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("PromotionDetailViewController") as! PromotionDetailViewController
        //print("test = \(vc.id)")
//        var test = promotionArray[pcPromotion.currentPage]
//        print("SELECTED ID: \(test.prom_id)")
//        vc.selectedPromotion = promotionArray[pcPromotion.currentPage]
//        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        pointNow = scrollView.contentOffset;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
         myTimer = NSTimer.scheduledTimerWithTimeInterval(4, target: self, selector: Selector("autoSlidePromotionImg"), userInfo: nil, repeats: true)
    }
    
    func autoSlidePromotionImg(){
        if (countTimer < pcPromotion.numberOfPages) {
            scvPromotion.setContentOffset(CGPointMake(CGFloat(countTimer*320), 0), animated: false)
            
        }else{
            countTimer = 0
            scvPromotion.setContentOffset(CGPointMake(CGFloat(countTimer*320), 0), animated: false)
        }
        countTimer++
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell1") as! UITableViewCell!
        cell.textLabel!.text = restaurantArray[indexPath.row]
        cell.textLabel?.font = customFont
        
        
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("SELECTED ROW : \(indexPath.row)")
        self.selectedRestaurant = indexPath.row
        self.performSegueWithIdentifier("selectedrestaurant", sender: nil)
    
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        print("1")
        if segue.identifier == "selectedrestaurant" {
            let branchListViewController = segue.destinationViewController as! BranchListViewController
            branchListViewController.selectedRestaurant = restaurantArray[selectedRestaurant]

        }
        
//        if let indexPath = self.tbvRestaurant.indexPathForSelectedRow()?.row {
//            print("2")
//            let restName = restaurantArray[indexPath.row]
//            print("3")
//            let destination = segue.destinationViewController as! BranchListViewController
//            print("4")
//            destination.rest = restName
//            
//            
//        }
    
    }
    

}
