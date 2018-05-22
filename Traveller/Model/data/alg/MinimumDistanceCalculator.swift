import Darwin

import Foundation

class MinimumDistanceCalculator {
    
    // guideA,user,guideB dont need id
    struct AlgParams {
        let map: [Position]
        let user: Position
        let guideA: Position
        let guideB: Position

    }
    
    // Calculates the 2D distance between two positions on the map
     static func distance(pos1:Position,pos2:Position) -> Double {
        return sqrt(pow(pos1.x-pos2.x,2) + pow(pos1.y-pos2.y,2))
    }
    
    // Returns true if 'stPos' is in the ideal range 'maxDistance', otherwise returns false
    static func isWithinPathRange(positions: [Position], stPos: Position,maxDistance:Double) -> Bool {
        let minDistance = positions.map{distance(pos1: $0, pos2: stPos)}.min()!
        return minDistance < maxDistance
    }
    
    static func getRelevantPath(map:[Position], guideA: Position, guideB: Position) -> [Position]{
        var positions = [Position]()
        let minA = map.min {
        distance(pos1: guideA, pos2: $0) < distance(pos1: guideA, pos2: $1)
        }?.id
        let minB = map.min {
            distance(pos1: guideB, pos2: $0) < distance(pos1: guideB, pos2: $1)
        }?.id

        let minPos = min(minA!, minB!)
        let maxPos = max(minA!, minB!)
        
        for i in minPos...maxPos {
            positions.append(map[i])
        }
        
        return positions
    }
    
    // This is the algorithm function
    static func isLegalPosition(params: AlgParams, maxDistance: Double) -> Bool {
        let markedPath = getRelevantPath(map: params.map, guideA:params.guideA, guideB: params.guideB)
        return isWithinPathRange(positions: markedPath, stPos: params.user, maxDistance:maxDistance)
    }
}

