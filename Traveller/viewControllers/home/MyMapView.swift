import UIKit
import MapKit

class MyMapView: MKMapView {
    
    var lineColor:UIColor!
    var lineWidth:CGFloat!
    var path:UIBezierPath!
    var touchPoint:CGPoint!
    var startingPoint:CGPoint!
    var shapeLayer = CAShapeLayer()
    var myPath = [Position]()
    var i = 0
    var drawing = false
    
    override func layoutSubviews() {
        self.clipsToBounds = true // no lines should be visible outside of the view
        self.isMultipleTouchEnabled = false // we only process one touch at a time
        
        // standard settings for our line
        lineColor = UIColor.blue
        lineWidth = 10
        
        super.layoutSubviews()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // get the touch position when user starts drawing
        let touch = touches.first
        startingPoint = touch?.location(in: self)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(drawing){
            // get the next touch point as the user draws
            let touch = touches.first
            touchPoint = touch?.location(in: self)
            
            let locCoord = self.convert(touchPoint, toCoordinateFrom: self)
            
            print("S: \(locCoord)")
            
            print(locCoord.latitude)
            
            myPath.append(Position(id: i, x: locCoord.latitude, y: locCoord.latitude))
            print("X: \(myPath[0].x)")
            i += 1
            
            // create path originating from the starting point to the next point the user reached
            path = UIBezierPath()
            path.move(to: startingPoint)
            path.addLine(to: touchPoint)
            
            // setting the startingPoint to the previous touchpoint
            // this updates while the user draws
            print(touchPoint)
            startingPoint = touchPoint
            
            drawShapeLayer() // draws the actual line shapes
        }else{
            super.touchesMoved(touches , with: event)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("End , \(myPath)")
        endPopUp()
    }
    
    func drawShapeLayer() {
        
        shapeLayer = CAShapeLayer()
        // the shape layer is used to draw along the already created path
        shapeLayer.path = path.cgPath
        
        // adjusting the shape to our wishes
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.fillColor = UIColor.clear.cgColor
        
        // adding the shapelayer to the vies layer and forcing a redraw
        self.layer.addSublayer(shapeLayer)
        self.setNeedsDisplay()
        
    }
    
    func clearCanvas() {
        path.removeAllPoints()
        shapeLayer.removeFromSuperlayer()
        myPath.removeAll()
        self.setNeedsDisplay()
    }
    
    func endPopUp(){
        if(drawing && myPath.isEmpty == false){
            TravellerNotification.GetMapNotification.post(data: myPath)
        }
    }
}

