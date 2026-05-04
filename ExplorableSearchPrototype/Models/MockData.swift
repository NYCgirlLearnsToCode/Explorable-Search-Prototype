//
//  MockData.swift
//  ExplorableSearchPrototype
//

import Foundation

struct Place: Identifiable {
    let id: UUID
    let title: String
    let description: String
    let imageName: String
    var isSaved: Bool
}

enum MockData {

    static let places: [Place] = [
        Place(
            id: UUID(),
            title: "Statue of Liberty",
            description: "An iconic neoclassical symbol of freedom in New York Harbor.",
            imageName: "ferry.fill",
            isSaved: false
        ),
        Place(
            id: UUID(),
            title: "Central Park",
            description: "An urban oasis with meadows, lakes, and winding scenic paths.",
            imageName: "leaf.fill",
            isSaved: false
        ),
        Place(
            id: UUID(),
            title: "Empire State Building",
            description: "A legendary Art Deco skyscraper with panoramic city views.",
            imageName: "building.2.fill",
            isSaved: false
        ),
        Place(
            id: UUID(),
            title: "Brooklyn Bridge",
            description: "Historic suspension bridge connecting Manhattan and Brooklyn.",
            imageName: "cable.connector",
            isSaved: true
        ),
        Place(
            id: UUID(),
            title: "Times Square",
            description: "Bright lights, giant screens, and nonstop Midtown energy.",
            imageName: "sparkles.rectangle.stack.fill",
            isSaved: false
        ),
        Place(
            id: UUID(),
            title: "Grand Central Terminal",
            description: "A Beaux-Arts landmark known for its celestial ceiling.",
            imageName: "tram.fill",
            isSaved: false
        ),
        Place(
            id: UUID(),
            title: "Rockefeller Center",
            description: "Famous for Top of the Rock, holiday tree, and city art deco.",
            imageName: "building.columns.fill",
            isSaved: false
        ),
        Place(
            id: UUID(),
            title: "One World Observatory",
            description: "Sky-high observation decks with sweeping skyline perspectives.",
            imageName: "viewfinder.circle.fill",
            isSaved: true
        ),
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
