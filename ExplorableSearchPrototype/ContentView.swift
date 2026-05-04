//
//  ContentView.swift
//  ExplorableSearchPrototype
//

import SwiftUI

struct ContentView: View {

    @State private var overviewExpanded = false
    @State private var sections = MockData.sections

    private static let carouselCardHeight: CGFloat = 240
    private static let carouselCardSpacing: CGFloat = 14

    var body: some View {
        ZStack(alignment: .top) {
            Color(.systemBackground)
                .ignoresSafeArea()

            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .leading, spacing: 0) {
                    fakeSearchBar

                    overviewSection

                    if overviewExpanded {
                        carouselsSection
                            .transition(.opacity .combined(with: .slide))
                    }
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
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }

    private var overviewSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(MockData.overviewTitle)
                .font(.subheadline.weight(.bold))
                .foregroundStyle(.secondary)
                .padding(.top, 24)

            Text(MockData.overviewShort)
                .font(.body)
                .foregroundStyle(.primary)
                .padding(.top, 8)

            Button {
                withAnimation(.easeInOut(duration: 0.28)) {
                    overviewExpanded.toggle()
                }
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

    private var carouselsSection: some View {
        VStack(alignment: .leading, spacing: 24) {
            ForEach(Array(sections.indices), id: \.self) { sectionIndex in
                sectionCarousel(sectionIndex: sectionIndex)
            }
        }
    }

    private func sectionCarousel(sectionIndex: Int) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(sections[sectionIndex].title)
                .font(.title3.weight(.semibold))
                .padding(.top, sectionIndex == 0 ? 28 : 0)

            GeometryReader { proxy in
                let cardWidth = carouselCardWidth(totalWidth: proxy.size.width)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: Self.carouselCardSpacing) {
                        ForEach(Array(sections[sectionIndex].places.indices), id: \.self) { placeIndex in
                            PlaceCardView(
                                place: $sections[sectionIndex].places[placeIndex],
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
