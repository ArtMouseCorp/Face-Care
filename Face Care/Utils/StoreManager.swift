import UIKit
import ApphudSDK
import StoreKit
import Amplitude

struct StoreManager {
    
    struct Product {
        var id: String
        var price: String
        var subscriptionPeriod: String
        var trialPeriod: String?
        var apphudProduct: ApphudProduct
        var skProduct: SKProduct
    }
    
    public static func updateStatus(completion: (() -> ())? = nil) {
        State.shared.isSubscribed = Apphud.hasActiveSubscription()
        completion?() ?? ()
    }
    
    public static func getProducts(for productIds: [String], completion: @escaping (([Product]) -> ())) {
        
        var foundProducts: [StoreManager.Product] = []
        
        Apphud.paywallsDidLoadCallback { paywalls in
            
            // retrieve current paywall with identifier
            
            let paywall = paywalls.first(where: { $0.isDefault })
            var products: [ApphudProduct] = []
            
            // retrieve the products [ApphudProduct] from current paywall
            if let paywall = paywall {
                products = paywall.products
            }
            
            for apphudProduct in products {
                
                guard let skProduct = apphudProduct.skProduct else { return }
                guard productIds.contains(skProduct.productIdentifier) else { continue }
                
                // Product price
                let price = skProduct.localizedPrice ?? skProduct.price.stringValue
                
                let subscriptionPeriod = skProduct.getSubscriptionPeriod()
                let trialPeriod = skProduct.getTrialPeriod()
                
                let customProduct = Product(id: skProduct.productIdentifier, price: price, subscriptionPeriod: subscriptionPeriod, trialPeriod: trialPeriod, apphudProduct: apphudProduct, skProduct: skProduct)
                
                foundProducts.append(customProduct)
            }
            
            completion(foundProducts)
            
        }
        
    }
    
    public static func purchase(_ product: Product, completion: (() -> ())? = nil) {

        Apphud.purchase(product.apphudProduct) { purchaseResult in
                
            if let subscription = purchaseResult.subscription, subscription.isActive() {
                
                Amplitude.instance().logEvent(AmplitudeEvent.subscriptionPurchased,
                                              withEventProperties: [
                                                "Transaction identifier": purchaseResult.transaction?.transactionIdentifier ?? "",
                                                "Transaction date": purchaseResult.transaction?.transactionDate ?? Date(),
                                                "Transaction product identifier": purchaseResult.transaction?.payment.productIdentifier ?? ""
                                              ])

                print("Purchase Success: \(product.id)")
                State.shared.isSubscribed = true
                completion?() ?? ()
            }
            
        }
        
    }
    
    public static func restore(completion: (() -> ())? = nil) {
        
        Apphud.restorePurchases{ subscriptions, purchases, error in
            
            if Apphud.hasActiveSubscription() {
                
                State.shared.isSubscribed = true
                topController().showRestoredAlert() {
                    completion?() ?? ()
                }
                
            } else {
                
                // no active subscription found, check non-renewing purchases or error
                topController().showNotSubscriberAlert()
                
            }
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