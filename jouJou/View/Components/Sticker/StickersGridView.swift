//
//  StickerTestView.swift
//  jouJou
//
//  Created by Alexandra Zarzar on 15/07/21.
//

import SwiftUI

struct StickersGridView: View {
    let stickers = ["heart.circle", "bed.double.fill", "star.fill", "moon.stars.fill", "paperplane.fill", "person.fill", "suit.club.fill", "flag.fill", "smoke.fill", "mappin.circle.fill", "hifispeaker.fill", "photo.fill.on.rectangle.fill", "gift.fill"]
    @State var stickersTapped: [String] = []
    
    var body: some View {
        GeometryReader{ geo in
            ScrollView{
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 3){
                    ForEach(stickers, id: \.self){ post in
                        Button(action: {
                              stickersTapped.append(post)
                        }) {
                            Image(systemName: post)
                            .frame(width: geo.size.width/3, height: geo.size.width/3)
                        }
                    }
                }
            }
        }
    }
}

struct StickerTestView_Previews: PreviewProvider {
    static var previews: some View {
        StickersGridView()
    }
}
