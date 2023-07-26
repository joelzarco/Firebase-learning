//
//  View+Extensions.swift
//  FirebaseGroceries
//
//  Created by sergio joel camacho zarco on 26/07/23.
//

import Foundation
import SwiftUI

extension View {
    func embedInNavigationView() -> some View {
        NavigationView { self }
    }
}
