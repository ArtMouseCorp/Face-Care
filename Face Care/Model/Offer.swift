import Foundation

struct Offer: Codable {
    let lang: Language.Code
    let trialTitle: String
    let notTrialTitle: String
    let button: String
    let purchaseId: String
    let comment: String
    
    public static let defaultOffer = Offer(lang: .en, trialTitle: "", notTrialTitle: "", button: L.get(key: L.Onboarding.OnboardingButton.continue), purchaseId: "fy_1y", comment: "I've been doing it for 3 months, I've been following the recommendations, and the effect is just WOW! This app is a diamond!")
    
    public static func get() {
        fetch { result in
            switch result {
            case .success(let offers):
                offers.forEach { offer in
                    if offer.lang == State.shared.getLanguage() {
                        State.shared.setOffer(to: offer)
                    }
                }
                break
            case .failure(let error):
                print(error.localizedDescription)
                print(error)
                
                let jsonData = readLocalJSONFile(forName: "offerScreen")!
                do {
                    let offers = try JSONDecoder().decode([Offer].self, from: jsonData)
                    
                    offers.forEach { offer in
                        if offer.lang == State.shared.getLanguage() {
                            State.shared.setOffer(to: offer)
                        }
                    }
                    
                } catch {
                    print("error: \(error)")
                }
                
                break
            }
        }
    }
    
    private static func fetch(completion: @escaping (Result<[Offer], Error>) -> Void) {
        
        // TODO: - Replace url
        
        let urlString = "https://app.finanse.space/app/NeverHaveI"
        guard let url = URL(string: urlString) else { fatalError() }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(error!))
                return
            }

            do {
                let offers = try JSONDecoder().decode([Offer].self, from: data)
                completion(.success(offers))
            } catch {
                completion(.failure(error))
            }

        }.resume()
    }
}
