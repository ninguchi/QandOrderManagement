//
//  PromotionDetailImageViewController.swift
//  Queue
//
//  Created by Kewalin Sakawattananon on 11/9/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import UIKit

class PromotionDetailImageViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var scrollView:UIScrollView!
    @IBOutlet weak var imgPromotionDetail:UIImageView!
    var selectedPromotion = PromotionModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.minimumZoomScale = 1;
        self.scrollView.maximumZoomScale = 6.0;
        imgPromotionDetail.image = UIImage(named: selectedPromotion.pro_pic_inner)
        self.scrollView.contentSize = self.imgPromotionDetail.frame.size;
        self.scrollView.delegate = self;
        let tap = UITapGestureRecognizer()
        tap.numberOfTapsRequired = 2
        tap.addTarget(self, action: "doubleTapped")
        view.userInteractionEnabled = true
        view.addGestureRecognizer(tap)
        var swipeDown: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "swipeDown")
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        view.addGestureRecognizer(swipeDown)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.imgPromotionDetail;
    }
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if self.scrollView.zoomScale > self.scrollView.minimumZoomScale {
            //self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func swipeDown(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func doubleTapped(){
        print("doubleTapped")
        if self.scrollView.zoomScale > self.scrollView.minimumZoomScale {
            self.scrollView.setZoomScale(self.scrollView.minimumZoomScale, animated: true)
        }else{
            self.scrollView.setZoomScale(self.scrollView.maximumZoomScale, animated: true)
        }
    }
    
    @IBAction func tappedCloseImageView(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
