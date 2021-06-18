import Foundation

class CoronaClass {
    
    var seats = [Int]()
    var n: Int
    
    init(n: Int) {
        self.n = n
    }
    
    private func getFreeDescs(for bounds: (Int, Int), maxDistance: inout Int, maxBounds: inout (Int, Int)) {
        var distance = 0
        // если первая или последняя парты, то считаем просто количество свободных парт
        if (bounds.1 == n - 1 && !seats.contains(n - 1)) || (bounds.0 == 0 && !seats.contains(0)){
            distance = bounds.1 - bounds.0 - 1
            // иначе считаем расстояние какое будет если посадить между ними человека
        } else {
            distance = (bounds.1 - bounds.0) / 2
        }
        if distance > maxDistance {
            maxDistance = distance
            maxBounds = (bounds.0 , bounds.1)
        }
    }
    
    private func takeSeat(number: Int) -> Int {
        seats.append(number)
        seats.sort(by: <)
        return number
    }
    
    func seat() -> Int {
        guard seats.count < n else {
            return -1
        }
        var maxDistance = 0
        var bounds: (Int, Int) = (left: 0, right: n - 1)
        // проверяем крайние парты
        // проверяем, свободна ли крайняя правая
        if !seats.contains(0) {
            // если все свободны, занимаем крайнюю правую
            if seats.count == 0 {
                return takeSeat(number: 0)
            }
            if let first = seats.first {
                getFreeDescs(for: (0,first), maxDistance: &maxDistance, maxBounds: &bounds)
            }
        }
        // проеряем, свободна ли крайняя левая
        if !seats.contains(n - 1) {
            if let last = seats.last {
                getFreeDescs(for: (last,n - 1), maxDistance: &maxDistance, maxBounds: &bounds)
            }
        }
        // проверяем расстояния между уже занятыми
        if seats.count > 1 {
            for i in 0...seats.count - 2 {
                // если две парты подряд заняты - нет смысла проверять
                if seats[i + 1] - seats[i] < 2 {
                    continue
                }
                getFreeDescs(for: (seats[i], seats[i + 1]), maxDistance: &maxDistance, maxBounds: &bounds)
            }
        }
        
        if bounds.0 == 0 && !seats.contains(0){
            return takeSeat(number: 0)
        }
        if bounds.1 == n - 1 && !seats.contains(n - 1){
            return takeSeat(number: n - 1)
        }
        
        return takeSeat(number: bounds.0 + maxDistance)
    }
    
    func leave(_ p: Int) {
        guard let index = seats.firstIndex(of: p) else {return}
        seats.remove(at: index)
    }
}
