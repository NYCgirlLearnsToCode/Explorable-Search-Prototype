//
//  PlaceCardView.swift
//  ExplorableSearchPrototype
//

import SwiftUI
import UIKit

struct PlaceCardView: View {
    let place: Place
    let width: CGFloat
    let height: CGFloat

    var body: some View {
        VStack(spacing: 0) {
            placeImage
                .resizable()
                .scaledToFill()
                .frame(height: height * 0.75)
                .frame(maxWidth: .infinity)
                .clipped()

            VStack(alignment: .leading, spacing: 4) {
                Text(place.title)
                    .font(.headline.weight(.bold))
                    .foregroundStyle(.primary)
                    .lineLimit(1)

                Text(place.description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(12)
            .frame(height: height * 0.25, alignment: .top)
            .background(Color(uiColor: .secondarySystemGroupedBackground))
        }
        .frame(width: width, height: height, alignment: .top)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color.black.opacity(0.04), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.14), radius: 8, x: 0, y: 4)
    }

    private var placeImage: Image {
        if UIImage(named: place.imageName) != nil {
            return Image(place.imageName)
        }

        return Image(systemName: place.imageName)
    }
}
