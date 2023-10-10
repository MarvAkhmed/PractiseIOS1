//
//  Product.swift
//  PractiseWork1Skvortsova
//
//  Created by Kseniya Skvortsova on 10.10.2023.
//

import Foundation
import UIKit

struct Product: Hashable, Identifiable {
    let id: UUID
    let name: String
    let subtitle: String
    let price: Int
    let picImage: UIImage?
}
