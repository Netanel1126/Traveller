import Darwin

import Foundation
class MinimumDistanceCalculator {
    
    // Calculates the 2D distance between two positions on the map
    private static func distance(pos1:Position,pos2:Position)->Double {
        var x1:Double=pos1.latitude!-pos2.latitude!
        x1=pow(x1,2)
        var x2=pos1.longitude!-pos2.longitude!
        x2=pow(x2,2)
        return sqrt(x1+x2)
    }
    
    // Returns the distance of the closest position to 'stPos'.
    // 'stPos' is the position from the GPS
    public static func getMinDistance(positions: [Position], stPos:Position) -> (Double,Position) {
        var minDistance:Double=Double.greatestFiniteMagnitude
        var minPos=positions[0]
        for pos in positions {
            let tmpMin=distance(pos1:pos,pos2:stPos)
            if tmpMin<minDistance
            {
                minDistance=tmpMin
                minPos=pos
            }
        }
        
        return (minDistance,minPos)
    }
    
    // Returns true if 'stPos' is in the ideal range 'maxDistance', otherwise returns false
    static func withinPathRange(positions: [Position], stPos: Position,maxDistance:Double) -> Bool {
        return getMinDistance(positions: positions,stPos: stPos).0 < maxDistance
    }
    
    // Returns the set of positions that represents the relevant/bounded path between the rearguard and the guide.
    // 'guide' and 'rearguard' are positions that relates to actual positions on the map (not from GPS).
    static func getRelevantPath(map:[Position],guide:Position,rearguard:Position) -> [Position]{
        var positions = [Position]()
        if(rearguard.id < guide.id){
        for pos in rearguard.id...guide.id{
            positions.append(map[pos])
        }
        }
        else {
            for pos in guide.id...rearguard.id{
                positions.append(map[pos])
            }
        }
        return positions
    }
    
    // This is the algorithm function
    static func isLegalPosition(map:[Position], posToCheck:Position, guide:Position, rearguard:Position, maxDistance: Double) -> Bool {
        let markedPath = getRelevantPath(map: map, guide:guide, rearguard:rearguard)
        return withinPathRange(positions: markedPath, stPos: posToCheck, maxDistance:maxDistance)
    }
}

