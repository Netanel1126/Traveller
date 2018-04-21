import UIKit
import MapKit

class MapViewController: UIViewController,MKMapViewDelegate,UISearchBarDelegate {
    
    @IBOutlet weak var myMap: MyMapView!
    var map:[Position]?
    var tripName:String?
    var tripDesc :String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myMap.delegate = self
        
        TravellerNotification.GetMapNotification.observe { (map) in
            self.map = map
            var alert = MapAlerts.getEndDrawingAlert(map: map!, myMap: self.myMap, tripName: self.tripName!, tripDesc: self.tripDesc!)
            self.present(alert, animated: true, completion: nil)
        }
        
        TravellerNotification.PopupEndNotification.observe { (annser) in
            if(annser)!{
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startToDraw(_ sender: Any) {
        var drawing:Bool
        
        if(myMap.drawing){
            drawing = false
            myMap.isScrollEnabled = true
        }else{
            drawing = true
            
            if(map != nil){
                MapAlerts.ChangeDrawingAlert(myMap: myMap, callback: { (alert) in
                    self.present(alert, animated: true, completion: nil)
                    self.map = self.myMap.myPath
                })
                
            }else{
                myMap.isScrollEnabled = false
            }
        }
        myMap.drawing = drawing
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer! {
        if(overlay is MKPolyline){
            let polylineRender = MKPolylineRenderer(overlay: overlay)
            polylineRender.strokeColor = UIColor.blue.withAlphaComponent(0.5)
            polylineRender.lineWidth = 5
            
            return polylineRender
        }
        
        return nil
    }
    
    @IBAction func searchButton(_ sender: Any) {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        present(searchController, animated: true, completion: nil)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        //Ignoring user
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        //Activity Indicator
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        self.view.addSubview(activityIndicator)
        
        //Hide search bar
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        
        //Create the search request
        let searchRequest = MKLocalSearchRequest()
        searchRequest.naturalLanguageQuery = searchBar.text
        
        let activeSearch = MKLocalSearch(request: searchRequest)
        
        activeSearch.start { (response, error) in
            
            activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            
            if response == nil
            {
                print("ERROR")
            }
            else
            {
                //Remove annotations
                let annotations = self.myMap.annotations
                self.myMap.removeAnnotations(annotations)
                
                //Getting data
                let latitude = response?.boundingRegion.center.latitude
                let longitude = response?.boundingRegion.center.longitude
                
                //Create annotation
                let annotation = MKPointAnnotation()
                annotation.title = searchBar.text
                annotation.coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
                self.myMap.addAnnotation(annotation)
                
                //Zooming in on annotation
                let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
                let span = MKCoordinateSpanMake(0.1, 0.1)
                let region = MKCoordinateRegionMake(coordinate, span)
                self.myMap.setRegion(region, animated: true)
            }
            
        }
    }
}
