//
//  AvatarRowView.swift
//  AvatarSample
//
//  Created by ncn on 2/24/25.
//  Copyright © 2025 wonkwh. All rights reserved.
//
import SwiftUI

struct AvatarEditProfileHandler: EnvironmentKey {
  static var defaultValue: (() -> Void)?
}

enum AvatarImageShape {
  case round
  case square
}

struct AvatarImageShapeKey: EnvironmentKey {
  static var defaultValue: AvatarImageShape = .round
}

extension EnvironmentValues {
  var editProfileHandler: (() -> Void)? {
    get { self[AvatarEditProfileHandler.self] }
    set { self[AvatarEditProfileHandler.self] = newValue }
  }
  
  var avatarImageShape: AvatarImageShape {
    get { self[AvatarImageShapeKey.self] }
    set { self[AvatarImageShapeKey.self] = newValue }
  }
}

extension View {
  func avatarImageShape(_ shape: AvatarImageShape) -> some View {
    environment(\.avatarImageShape, shape)
  }
  
  public func onEditProfile(handler: @escaping () -> Void) -> some View {
    environment(\.editProfileHandler, handler)
  }
}

struct AvatarRowView: View {
  @Environment(\.avatarImageShape) var imageShape
  @Environment(\.editProfileHandler) var editProfileHandler
  
  var person: Person
  
  @ViewBuilder
  private var profileImage: some View {
    if imageShape == .round {
      Image(person.profileImageName)
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(width: 75, height: 75, alignment: .center)
        .clipShape(.circle)
        .accessibilityLabel(person.fullName)
    } else {
      Image(person.profileImageName)
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(width: 75, height: 75, alignment: .center)
        .accessibilityLabel(person.fullName)
    }
  }
                          
  private var titleLabel: some View {
    Text(person.fullName)
      .font(.headline)
  }
  
  private func detailsLabel(_ text: String) -> some View {
    Text(text)
      .font(.subheadline)
  }
  
  var body: some View {
    HStack(alignment: .top) {
      profileImage
        .onTapGesture {
          editProfileHandler?()
        }
      VStack(alignment: .leading) {
        titleLabel
        detailsLabel(person.jobtitle)
        detailsLabel(person.affiliation)
      }
      Spacer()
    }
    .accessibilityElement(children: .contain)
    .accessibilityLabel(person.fullName)
  }
}

#Preview {
  AvatarRowView(person: Person.sample)
  AvatarRowView(person: Person.sample)
    .avatarImageShape(.round)
    .onEditProfile {
      print("Edit Profile")
    }
    .padding()
  AvatarRowView(person: Person.sample)
    .avatarImageShape(.square)
    .padding()
}

