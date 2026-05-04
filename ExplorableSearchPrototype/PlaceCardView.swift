//
//  PlaceCardView.swift
//  ExplorableSearchPrototype
//

import SwiftUI

struct PlaceCardView: View {
    @Binding var place: Place
    let width: CGFloat
    let height: CGFloat

    private var bottomMinHeight: CGFloat { max(height * 0.25, 84) }
    private var imageHeight: CGFloat { max(0, height - bottomMinHeight) }

    var body: some View {
        VStack(spacing: 0) {
            // Clip only the photo. Putting the save control inside a fully `.clipped()`
            // ZStack clips the trailing/top of the circle; card `clipShape` can also
            // bisect a corner-placed control—use an overlay and inset from the corner arc.
            placeImage
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
                .frame(height: imageHeight)
                .clipped()
                .overlay(alignment: .topTrailing) {
                    saveButton
                        .padding(.top, 12)
                        .padding(.trailing, 12)
                }
                .layoutPriority(0)

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
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .frame(minHeight: bottomMinHeight, alignment: .top)
            .background(Color(.secondarySystemGroupedBackground))
            .layoutPriority(1)
        }
        .frame(width: width, height: height, alignment: .top)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color.black.opacity(0.04), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.14), radius: 8, x: 0, y: 4)
    }

    private var saveButton: some View {
        Button {
            withAnimation(.spring(response: 0.38, dampingFraction: 0.68)) {
                place.isSaved.toggle()
            }
        } label: {
            Image(systemName: place.isSaved ? "heart.fill" : "heart")
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(.white)
                .padding(8)
                .background(.ultraThinMaterial, in: Circle())
                .scaleEffect(place.isSaved ? 1.12 : 1.0)
                .padding(4)
        }
        .buttonStyle(.plain)
        .accessibilityLabel(place.isSaved ? "Remove from saved" : "Save")
    }

    private var placeImage: Image {
        return Image(systemName: place.imageName)
    }
}

#Preview {
    struct PlaceCardPreview: View {
        @State private var place = MockData.places[0]
        var body: some View {
            PlaceCardView(place: $place, width: 160, height: 240)
        }
    }
    return PlaceCardPreview()
}
