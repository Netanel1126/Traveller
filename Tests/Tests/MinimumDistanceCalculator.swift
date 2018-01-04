//
//  DistanceCalculator.swift
//  Tests
//
//  Created by admin on 04/01/2018.
//  Copyright © 2018 admin. All rights reserved.
//
import Darwin

import Foundation
class MinimumDistanceCalculator {
    
    private static func distance(pos1:Position,pos2:Position)->Double {
        var x1:Double=pos1.x!-pos2.x!
        x1=pow(x1,2)
        var x2=pos1.y!-pos2.y!
        x2=pow(x2,2)
        return sqrt(x1+x2)
    }
    
    private static func getMinDistance(positions: [Position], stPos:Position) -> (Double, Position) {
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
    
    static func minLocation(positions: [Position], stPos: Position, maxDistance: Double) -> Bool {
        return getMinDistance(positions: positions,stPos: stPos).0 < maxDistance
    }
    
    //args: position: [measefPos-1,guidePos+1]
    static func withinPathRange(positions: [Position], stPos: Position) -> Bool {
        var measefPos = positions[1]
        var guidePos = positions[positions.count - 2]
        
        let result=getMinDistance(positions: positions, stPos: stPos)
        let resultId=result.1.id
        let resultPos=result.1
        let distance=result.0
        if((resultId! > guidePos.id!) || (resultId! < measefPos.id!)){
            return false
        }
        if resultId == guidePos.id {
            distance(pos1: resultPos, pos2: resultPos)
            distance(pos1: resultPos, pos2: resultPos)
            if(){
                
            }
        }
        return true
    }
}
