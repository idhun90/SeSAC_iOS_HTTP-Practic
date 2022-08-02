import Foundation
import UIKit

protocol ReusableProtocol {
    static var id: String { get }
}

extension UIViewController: ReusableProtocol {
    static var id: String {
        return String(describing: self)
    }
    
    
}

extension UITableViewCell: ReusableProtocol {
    static var id: String {
        return String(describing: self)
    }
    
    
}
