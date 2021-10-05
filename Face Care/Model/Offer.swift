import Foundation

struct Offer: Codable {
    let lang: Language.Code
    let title: String
    let button: String
    let purchaseId: String
    let text1: String
    let text2: String
    let text3: String
    
    let view: Bool
    let showOnCount: Int
    let categoriesEnabled: Bool
    
    let giftPurchaseId: String
    let giftPriceText: String
    let giftOldPrice: String
    
    public static let defaultOffer = Offer(lang: .en, title: "Title", button: "Play", purchaseId: "7", text1: "Text1", text2: "Text2", text3: "Text3", view: true, showOnCount: 1, categoriesEnabled: true, giftPurchaseId: "", giftPriceText: "", giftOldPrice: "")
    
    public static func get() {
        fetch { result in
            switch result {
            case .success(let offers):
                offers.forEach { offer in
                    if offer.lang == State.shared.getLanguage() {
                        State.shared.offer = offer
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
                            State.shared.offer = offer
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
