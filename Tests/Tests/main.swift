import Foundation


let position=[Position(id:0,x:5,y:3),Position(id:1,x:1,y:2),Position(id:2,x:4,y:6),Position(id:3,x:3,y:3),Position(id:4,x:7,y:7)]

print(MinimumDistanceCalculator.withinPathRange(positions: position, stPos: Position(id:nil,x: 0,y: 0), maxDistance: 10))

print(MinimumDistanceCalculator.withinPathRange(positions: position, stPos: Position(id:nil,x: 0,y: 0), maxDistance: 2))

var pos = MinimumDistanceCalculator.getRelevantPath(map: position, guide: Position(id:3,x:3,y:3), rearguard:  Position(id:1,x:1,y:2))

print("new Path")
for p in pos{
    print("X: \(p.x!) Y: \(p.y!)")
}

