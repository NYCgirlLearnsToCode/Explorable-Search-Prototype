//
//  MockData.swift
//  ExplorableSearchPrototype
//

import SwiftUI

struct Landmark: Identifiable {
    let id: String
    let name: String
    let subtitle: String
    let symbolName: String
    let symbolColor: Color
}

enum MockData {

    static let landmarks: [Landmark] = [
        Landmark(id: "eiffel", name: "Eiffel Tower", subtitle: "Paris, France", symbolName: "building.columns.fill", symbolColor: .indigo),
        Landmark(id: "liberty", name: "Statue of Liberty", subtitle: "New York, USA", symbolName: "flame.fill", symbolColor: .teal),
        Landmark(id: "wall", name: "Great Wall", subtitle: "China", symbolName: "mountain.2.fill", symbolColor: .brown),
        Landmark(id: "taj", name: "Taj Mahal", subtitle: "Agra, India", symbolName: "sun.max.fill", symbolColor: .orange),
        Landmark(id: "colosseum", name: "Colosseum", subtitle: "Rome, Italy", symbolName: "theatermasks.fill", symbolColor: .red),
    ]

    static let overviewTitle = "AI Overview"

    static let overviewShort = """
    Landmarks are cultural touchstones—bridges between history, art, and memory. \
    They shape how we picture a place before we ever visit.
    """

    static let overviewFull = overviewShort + """

    Exploring them is less about ticking boxes than noticing how millions of tiny stories converge in one skyline, façade, or horizon.
    """
}
