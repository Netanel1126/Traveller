import UIKit

class MapAlerts{
    
    static func getEndDrawingAlert(onComplete: @escaping (Bool) -> Void) -> UIAlertController{
        let alert = UIAlertController(title: "Are you finish editing?", message: "", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Apply", style: .default){
            (action) in
            onComplete(true)
        }
        let action2 = UIAlertAction(title: "Dismiss", style: .destructive){
            (action) in
            onComplete(false)
        }
        alert.addAction(action1)
        alert.addAction(action2)
        return alert
    }
}

