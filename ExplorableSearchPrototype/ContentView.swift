//
//  ContentView.swift
//  ExplorableSearchPrototype
//

import SwiftUI

struct ContentView: View {

    @State private var overviewExpanded = false
    @State private var sections = MockData.sections
    @State private var showShortlist = false

    private static let carouselCardHeight: CGFloat = 240
    private static let carouselCardSpacing: CGFloat = 14

    // MARK: - Derived state

    private var savedPlaces: [Place] {
        sections.flatMap { $0.places }.filter { $0.isSaved }
    }

    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()

            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .leading, spacing: 0) {
                    fakeSearchBar
                    overviewSection

                    if overviewExpanded {
                        carouselsSection
                            .transition(.opacity.combined(with: .slide))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 32)
            }

            // Floating shortlist pill
            if !savedPlaces.isEmpty {
                shortlistPill
                    .padding(.trailing, 20)
                    .padding(.bottom, 24)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                    .transition(.scale.combined(with: .opacity))
            }
        }
        .animation(.spring(), value: savedPlaces.count)
    }

    // MARK: - Search Bar

    private var fakeSearchBar: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)

            Text("Things to do nyc")
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

    // MARK: - Overview

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

    // MARK: - Carousels

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

    // MARK: - Shortlist Pill

    private var shortlistPill: some View {
        Button {
            showShortlist = true
        } label: {
            HStack(spacing: 8) {
                Image(systemName: "heart.fill")
                Text("Saved (\(savedPlaces.count))")
                    .font(.subheadline.weight(.semibold))
            }
            .foregroundStyle(.white)
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            .background(Color.black)
            .clipShape(Capsule())
            .shadow(radius: 6)
        }
        .buttonStyle(.plain)
        .sheet(isPresented: $showShortlist) {
            shortlistSheet
        }
    }

    // MARK: - Shortlist Sheet

    private var shortlistSheet: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Your shortlist")
                    .font(.title2.weight(.semibold))

                Spacer()

                Button("Done") {
                    showShortlist = false
                }
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 14) {
                    ForEach(savedPlaces.indices, id: \.self) { index in
                        if let binding = bindingForPlace(savedPlaces[index]) {
                            PlaceCardView(
                                place: binding,
                                width: 160,
                                height: 220
                            )
                        }
                    }
                }
            }

            Spacer()
        }
        .padding(20)
        .presentationDetents([.medium])
    }

    // MARK: - Binding helper

    private func bindingForPlace(_ place: Place) -> Binding<Place>? {
        for sectionIndex in sections.indices {
            if let placeIndex = sections[sectionIndex].places.firstIndex(where: { $0.id == place.id }) {
                return $sections[sectionIndex].places[placeIndex]
            }
        }
        return nil
    }
}

#Preview {
    ContentView()
}
