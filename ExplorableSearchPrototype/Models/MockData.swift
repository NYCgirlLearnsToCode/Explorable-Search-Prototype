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

struct PlaceSection: Identifiable {
    let id: UUID
    let title: String
    var places: [Place]
}

enum MockData {

    static let sections: [PlaceSection] = [
        PlaceSection(
            id: UUID(),
            title: "Iconic Landmarks & Sightseeing",
            places: [
                Place(id: UUID(), title: "Central Park", description: "Walk to Bethesda Fountain, Bow Bridge, and Belvedere Castle.", imageName: "leaf.fill", isSaved: false),
                Place(id: UUID(), title: "Times Square", description: "Experience the heart of the city's neon lights and energy.", imageName: "sparkles.rectangle.stack.fill", isSaved: false),
                Place(id: UUID(), title: "Statue of Liberty & Ellis Island", description: "Visit iconic symbols of American freedom in New York Harbor.", imageName: "ferry.fill", isSaved: false),
                Place(id: UUID(), title: "Brooklyn Bridge & DUMBO", description: "Walk across for skyline views, then explore the trendy DUMBO neighborhood.", imageName: "bridge.doubledeck", isSaved: false),
                Place(id: UUID(), title: "Rockefeller Center", description: "Famous for its ice rink and holiday festivities.", imageName: "building.columns.fill", isSaved: false),
                Place(id: UUID(), title: "Empire State Building", description: "Experience the classic observation deck experience.", imageName: "building.2.fill", isSaved: false),
                Place(id: UUID(), title: "Grand Central Terminal", description: "Visit the historic station, featuring a celestial ceiling.", imageName: "tram.fill", isSaved: false),
            ]
        ),
        PlaceSection(
            id: UUID(),
            title: "Museums & Culture",
            places: [
                Place(id: UUID(), title: "The Met", description: "One of the world's largest and most celebrated art museums.", imageName: "paintpalette.fill", isSaved: false),
                Place(id: UUID(), title: "9/11 Memorial & Museum", description: "A solemn, essential historical site in Lower Manhattan.", imageName: "building.columns.circle.fill", isSaved: false),
                Place(id: UUID(), title: "American Museum of Natural History", description: "Known for dinosaur fossils and the planetarium.", imageName: "teddybear.fill", isSaved: false),
                Place(id: UUID(), title: "Tenement Museum", description: "A look into the lives of early immigrants in the Lower East Side.", imageName: "person.3.fill", isSaved: false),
                Place(id: UUID(), title: "The Cloisters", description: "Dedicated to medieval European art and architecture.", imageName: "building.columns.circle", isSaved: false),
                Place(id: UUID(), title: "Madame Tussauds New York", description: "Interactive wax museum in Times Square.", imageName: "person.crop.rectangle.stack.fill", isSaved: false),
            ]
        )
    ]

    static let overviewTitle = "AI Overview"

    static let overviewShort = """
    NYC offers iconic sights, world-class museums, and distinct neighborhoods. Top attractions include strolling the High Line, visiting Central Park and the Statue of Liberty, exploring Times Square, and visiting museums like The Met.
    """
}
