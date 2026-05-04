//
//  ContentView.swift
//  ExplorableSearchPrototype
//

import SwiftUI

struct ContentView: View {

    @State private var overviewExpanded = false

    private static let carouselCardHeight: CGFloat = 240
    private static let carouselCardSpacing: CGFloat = 14

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
                    LazyHStack(spacing: Self.carouselCardSpacing) {
                        ForEach(MockData.places) { place in
                            PlaceCardView(
                                place: place,
                                width: cardWidth,
                                height: Self.carouselCardHeight
                            )
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
        let cardsVisible: CGFloat = 2.5
        let usable = max(totalWidth, 280)
        let spacingBudget = Self.carouselCardSpacing * (cardsVisible - 1)
        return (usable - spacingBudget) / cardsVisible
    }
}

#Preview {
    ContentView()
}
