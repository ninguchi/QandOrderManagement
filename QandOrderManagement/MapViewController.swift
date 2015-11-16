//
//  ViewController.swift
//  Queue
//
//  Created by Kewalin Sakawattananon on 11/6/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController,MKMapViewDelegate,UIPopoverPresentationControllerDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var vMapView: MKMapView!
    let locationManager = CLLocationManager()
    let regionRadius: CLLocationDistance = 10
    var latitude:Double = 0.0
    var longitude:Double = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.vMapView.delegate = self
        self.centerMapOnLocation()
        self.pointMapOnLocation()
        
    }
    
    // MARK: - Pin and centerlize MapView
    func centerMapOnLocation(){
        
        self.locationManager.delegate = self
        //self.locationManager.distanceFilter = 100.0
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()

        self.vMapView.showsUserLocation = true
        
        /*
        if vMapView.annotations.count == 0 {
            return
        }
        var topLeftCoord: CLLocationCoordinate2D = CLLocationCoordinate2D()
        topLeftCoord.latitude = -90
        topLeftCoord.longitude = 180
        var bottomRightCoord: CLLocationCoordinate2D = CLLocationCoordinate2D()
        bottomRightCoord.latitude = 90
        bottomRightCoord.longitude = -180
        for annotation: MKAnnotation in vMapView.annotations as [MKAnnotation]{
            topLeftCoord.longitude = fmin(topLeftCoord.longitude, annotation.coordinate.longitude)
            topLeftCoord.latitude = fmax(topLeftCoord.latitude, annotation.coordinate.latitude)
            bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, annotation.coordinate.longitude)
            bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, annotation.coordinate.latitude)
        }
        
        var region: MKCoordinateRegion = MKCoordinateRegion()
        region.center.latitude = topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) * 0.5
        region.center.longitude = topLeftCoord.longitude + (bottomRightCoord.longitude - topLeftCoord.longitude) * 0.5
        region.span.latitudeDelta = fabs(topLeftCoord.latitude - bottomRightCoord.latitude) * 2
        region.span.longitudeDelta = fabs(bottomRightCoord.longitude - topLeftCoord.longitude) * 2
        region = vMapView.regionThatFits(region)
        vMapView.setRegion(region, animated: true)
        */
        
    }
    func pointMapOnLocation(){
        let restaurantArray = RestaurantController().getAllRestaurant()
        for res in restaurantArray {
            let lat = res.res_latitude
            let long = res.res_longitude
            let location = CLLocation(latitude: lat, longitude: long)
            let point:MKPointAnnotation = MKPointAnnotation()
            point.coordinate = location.coordinate
            point.title = "pin"
            point.subtitle = String(res.res_id)
            self.vMapView.addAnnotation(point)
        }
    }
    // MARK: - MapView delegate
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        if (view.annotation?.title)! == "pin" {
            mapView.deselectAnnotation(view.annotation, animated: true)
            let controller = self.storyboard?.instantiateViewControllerWithIdentifier("PopOverDetailMapViewController") as! PopOverDetailMapViewController
            controller.resId = ((view.annotation?.subtitle)!)!
            controller.modalPresentationStyle = .Popover
            controller.view.layer.borderWidth = 0.8
            controller.view.layer.cornerRadius = 10.0
            controller.view.layer.borderColor = UIColor(red: 1.0/255.0, green: 78.0/255.0, blue: 44.0/255.0, alpha: 1.0).CGColor
            
            if let popover = controller.popoverPresentationController {

                popover.sourceView = view
            
                // the position of the popover where it's showed
                    popover.sourceRect = view.bounds
            
                // the size you want to display
                controller.preferredContentSize = CGSizeMake(200,100)
                popover.delegate = self
            }
        
            self.presentViewController(controller, animated: true, completion: nil)
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.title! == "pin" {
            let annotationView = PinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
            return annotationView
        }else{
            return nil
        }
    }

    // Current Location
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        
        print("\(location!.coordinate.latitude), \(location!.coordinate.longitude)")
        
        let region = MKCoordinateRegionMakeWithDistance(location!.coordinate, 6000, 6000)
        vMapView.setRegion(region, animated: true)
        self.locationManager.stopUpdatingLocation()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

