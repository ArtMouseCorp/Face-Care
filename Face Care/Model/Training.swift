import Foundation

class Training: Codable {
    
    var name: String
    var description: String
    let duration: Int
    let exercises: [Exercise]
    
    init(name: String, description: String, duration: Int, exercises: [Exercise]) {
        self.name = name
        self.description = description
        self.duration = duration
        self.exercises = exercises
    }
    
    public static let `default` = Training(name: "Training", description: "Training description", duration: 7, exercises: [])
    
    struct Exclusive {
        
        public static var trainings: [Training] = []
        
        public static func createTrainings() {
            
            trainings.removeAll()
            
            for faceArea in FaceArea.all {
                
                if let exercise = faceArea.exercises.randomElement() {
                    
                    let training = Training(name: exercise.name, description: exercise.description, duration: exercise.duration, exercises: [exercise])
                    
                    trainings.append(training)
                    
                }
                    
            }
            
            saveToJson()
            
        }
        
        public static func localizeTrainings() {
            
            let allExercises = FaceArea.getAllExercises()
            
            for training in trainings {
                
                for exercise in training.exercises {

                    if let localizedExercise = allExercises.first(where: { $0.id == exercise.id }) {
                        exercise.localize(from: localizedExercise)
                        training.name = localizedExercise.name
                        training.description = localizedExercise.description
                    }

                }
                
            }
            
        }
        
        public static func saveToJson() {
            
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted

            do {
                let jsonData = try encoder.encode(trainings)

                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    
                    let filename = getDocumentsDirectory().appendingPathComponent("exclusiveTrainings.json")
                    do {
                        try jsonString.write(to: filename, atomically: true, encoding: .utf8)
                        print("Exclusive trainings successfully saved to \(filename)")
                    } catch {
                        // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
                        print("Failed writing to URL: \(filename), Error: " + error.localizedDescription)
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
            
        }
        
        public static func loadFromJson() {
            
            let filename = getDocumentsDirectory().appendingPathComponent("exclusiveTrainings.json")
            
            do {
                let jsonData = try Data(contentsOf: filename)
                
                print("Loaded from \(filename)")

                let decoder = JSONDecoder()

                let exclusiveTrainings = try decoder.decode([Training].self, from: jsonData)
                self.trainings = exclusiveTrainings
                self.localizeTrainings()
                
            } catch {
                print("error: \(error.localizedDescription)")
            }
            
            
        }
        
    }
    
    struct Daily: Codable {
        
        private static let MAX_EXERCISES = 7
        
        let dayNumber: Int
        let isOpen: Bool
        let training: Training
        
        public static var trainings: [Daily] = []
        
        public static func createTrainings() {
            
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
                
                saveToJson()
                
            }
            
        }
        
        public static func saveToJson() {
            
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted

            do {
                let jsonData = try encoder.encode(trainings)

                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    
                    let filename = getDocumentsDirectory().appendingPathComponent("userTrainings.json")
                    do {
                        try jsonString.write(to: filename, atomically: true, encoding: .utf8)
                        print("User trainings successfully saved to \(filename)")
                    } catch {
                        // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
                        print("Failed writing to URL: \(filename), Error: " + error.localizedDescription)
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
            
        }
        
        public static func loadFromJson() {
            
            let filename = getDocumentsDirectory().appendingPathComponent("userTrainings.json")
            
            do {
                let jsonData = try Data(contentsOf: filename)
                
                print("Loaded from \(filename)")

                let decoder = JSONDecoder()

                let dailyTrainings = try decoder.decode([Training.Daily].self, from: jsonData)
                self.trainings = dailyTrainings
                self.localizeTrainings()
                
            } catch {
                print("error: \(error.localizedDescription)")
            }
            
            
        }
        
        public static func localizeTrainings() {
            
            let allExercises = FaceArea.getAllExercises()
            
            for training in trainings {
                
                for exercise in training.training.exercises {

                    if let localizedExercise = allExercises.first(where: { $0.id == exercise.id }) {
                        exercise.localize(from: localizedExercise)
                    }

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
