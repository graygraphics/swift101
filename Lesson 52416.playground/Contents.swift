//: Playground - noun: a place where people can play

import UIKit

enum ProductType {
    case Books
    case Appareal
    case Toys
    case Sporting
    case Beauty
    case None
}

struct Product:Equatable {
    var name: String?
    var price: Float?
    var amount = 1
    var type: ProductType?
    var id:String?
    
    func methodName() {
        
    }
}

func == (lhs: Product, rhs: Product) -> Bool {
    return lhs.id == rhs.id
}

extension Array where Element:Equatable {
    mutating func removeObject(object: Element) {
        if let index = self.indexOf(object) {
            self.removeAtIndex(index)
        }
    }
}

extension Float {
    func displayPrice(price: Float) -> String {
        return NSString(format: "$%.2f", price) as String
    }
}

class CartManager {
    static let shared = CartManager()
    private init() {}

    var products:[Product] = []
    
    func add(product: Product) {
        let isProductInCart = find(product)
        if isProductInCart {
            let prod = products.filter { $0 == product }.first
            guard let product = prod else {
                return
            }
            update(product)
        } else {
            print("Product not found \(product)")
            products.append(product)
        }
    }
    
    func update(product: Product) {
        var updatedProduct = product
        updatedProduct.amount = updatedProduct.amount + 1
        products.append(updatedProduct)
        print("amt \(updatedProduct.amount)")
        remove(product)
    }

    func remove(product: Product) {
        products.removeObject(product)
    }
    
    private func find(product: Product) -> Bool {
        return products.contains(product)
    }
    
    func displayCartItems() {
        for product in products {
            print("Product: \(product.name) Amount: \(product.amount)")
        }
    }
}

var product1 = Product()
product1.name = "tshirt"
product1.price = 10.00
product1.type = .Appareal
product1.id = NSUUID().UUIDString

var product2 = Product()
product2.name = "tshirt"
product2.price = 10.00
product2.type = .Appareal
product2.id = NSUUID().UUIDString

var product3 = Product()
product3.name = "tshirt"
product3.price = 10.00
product3.type = .Appareal
product3.id = NSUUID().UUIDString

CartManager.shared.add(product1)
CartManager.shared.add(product2)
CartManager.shared.add(product3)
CartManager.shared.remove(product3)
CartManager.shared.add(product1)
CartManager.shared.add(product1)
CartManager.shared.add(product1)


//print(CartManager.shared.products.count)
CartManager.shared.displayCartItems()
