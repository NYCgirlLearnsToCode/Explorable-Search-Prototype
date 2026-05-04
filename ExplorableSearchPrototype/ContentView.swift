//
//  ContentView.swift
//  ExplorableSearchPrototype
//

import SwiftUI
import UIKit

struct ContentView: View {

    @State private var overviewExpanded = false

    private static let carouselCardHeight: CGFloat = 240

    var body: some View {
        ZStack(alignment: .top) {
            Color(uiColor: .systemGroupedBackground)
                .ignoresSafeArea()

            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .leading, spacing: 0) {
                    fakeSearchBar

                    overviewSection

                    carouselSection
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 32)
            }
        }
    }

    private var fakeSearchBar: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)

            Text("Search landmarks, cities, or topics")
                .foregroundStyle(.secondary)
                .font(.body)

            Spacer(minLength: 0)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .frame(minHeight: 48)
        .background(Color(uiColor: .secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }

    private var overviewSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(MockData.overviewTitle)
                .font(.subheadline.weight(.bold))
                .foregroundStyle(.secondary)
                .padding(.top, 24)

            Text(overviewExpanded ? MockData.overviewFull : MockData.overviewShort)
                .font(.body)
                .foregroundStyle(.primary)
                .padding(.top, 8)
                .animation(.easeInOut(duration: 0.2), value: overviewExpanded)

            Button {
                overviewExpanded.toggle()
            } label: {
                Text(overviewExpanded ? "Show less" : "Show more")
                    .font(.subheadline.weight(.semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 10)
                    .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
        }
    }

    private var carouselSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Iconic Landmarks")
                .font(.title3.weight(.semibold))
                .padding(.top, 28)

            GeometryReader { proxy in
                let cardWidth = carouselCardWidth(totalWidth: proxy.size.width)

                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 14) {
                        ForEach(MockData.landmarks) { landmark in
                            LandmarkCarouselCard(landmark: landmark, width: cardWidth)
                        }
                    }
                    .padding(.vertical, 2)
                }
                .frame(height: Self.carouselCardHeight)
            }
            .frame(height: Self.carouselCardHeight)
        }
    }

    private func carouselCardWidth(totalWidth: CGFloat) -> CGFloat {
        let usable = max(totalWidth, 240)
        return max(240, min(usable * 0.72, 300))
    }
}

private struct LandmarkCarouselCard: View {
    let landmark: Landmark
    let width: CGFloat

    private var iconHeight: CGFloat {
        width * 0.58
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Image(systemName: landmark.symbolName)
                .font(.system(size: 36, weight: .medium))
                .foregroundStyle(.white.opacity(0.92))
                .frame(maxWidth: .infinity)
                .frame(height: iconHeight)
                .background(landmark.symbolColor)

            VStack(alignment: .leading, spacing: 4) {
                Text(landmark.name)
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .lineLimit(2)

                Text(landmark.subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
            .padding(14)
        }
        .frame(width: width, alignment: .leading)
        .background(Color(uiColor: .secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}

#Preview {
    ContentView()
}
