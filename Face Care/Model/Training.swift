import Foundation

struct Training {
    
    let name: String
    let description: String
    let duration: Int
    let exercises: [Exercise]
    
    public static let `default` = Training(name: "Training", description: "Training description", duration: 7, exercises: [])
    
    struct Daily {
        
        private static let MAX_EXERCISES = 7
        
        let dayNumber: Int
        let isOpen: Bool
        let training: Training
        
        public static var trainings: [Daily] = []
        
        public static func getTrainings() {
            
            trainings.removeAll()
            
            parseDailyData { faceAreaDailyData in
                
//                print("Problem areas array: ", State.shared.getProblemAreas())
                let faceAreaDailyData = faceAreaDailyData.filter { State.shared.getProblemAreas().contains($0.faceAreaId) }
//                print(faceAreaDailyData)
                let exercisesCount = Int(MAX_EXERCISES / faceAreaDailyData.count)
//                print("Exercises count: ", exercisesCount)
                
                for i in 0 ..< 7 {
                    
                    var exercises: [Exercise] = []
                    var trainingDuration: Int = 0
                    
                    for faceAreaTraining in faceAreaDailyData {
                        
                        var exercisesIds: [Int] = []
                        
                        if exercisesCount > faceAreaTraining.days[i].count {
                            exercisesIds = faceAreaTraining.days[i].random(elements: faceAreaTraining.days[i].count)
                        } else {
                            exercisesIds = faceAreaTraining.days[i].random(elements: exercisesCount)
                        }
                        
//                        print("Face area trainings: ", faceAreaTraining)
//                        print("Ids: ", exercisesIds)
                     
                        
                        if let faceArea = FaceArea.all.first(where: {$0.id == faceAreaTraining.faceAreaId} ) {
                            
                            faceArea.exercises.filter({exercisesIds.contains($0.id)}).forEach({
                                exercises.append($0)
                                trainingDuration += $0.duration
                            })
                            
                        }
                        
                    }
                    
//                    print("Exercises: ", exercises)
                    
                    let training = Training(
                        name: "Day \(i + 1) training",
                        description: "Day \(i + 1) training description",
                        duration: Int(trainingDuration / 60),
                        exercises: exercises
                    )
                    let dailyTraining = Daily(dayNumber: i + 1, isOpen: i == 0 ? true : false, training: training)
                    trainings.append(dailyTraining)
                    
                }
                
            }
            
        }
        
        private static func parseDailyData(completion: (([FaceAreaDailyData]) -> ())) {
            
            var faceAreaDailyDataArray: [FaceAreaDailyData] = []

            guard let jsonData = readLocalJSONFile(forName: "dailyTrainings") else { return }
            
            do {
                let decodedData = try JSONDecoder().decode(Daily.Response.self, from: jsonData)
                faceAreaDailyDataArray = decodedData.facaAreaDailyTrainings
                completion(faceAreaDailyDataArray)
            } catch {
                print("Error: ", error)
            }
            
        }
        
        private struct Response: Codable {
            let facaAreaDailyTrainings: [FaceAreaDailyData]
        }
        
        private struct FaceAreaDailyData: Codable {
            let faceAreaId: Int
            let days: [[Int]]
        }
        
    }
    
    struct Exclusive {
        
        
        
    }
    
    
}

/*
 //           _._
 //        .-'   `
 //      __|__
 //     /     \
 //     |()_()|
 //     \{o o}/
 //      =\o/=
 //       ^ ^
 */
