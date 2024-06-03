//
//  ImmersiveView.swift
//  Poker
//
//  Created by Abby Nayeri  on 2024-05-30.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
    
    @State var headEntity: Entity = {
        let headAnchor = AnchorEntity(.head)
        headAnchor.position = [0, 0, -1]
        return headAnchor
    }()
    
    @State var wallEntity: Entity = {
        let wallAnchor = AnchorEntity( .plane(.vertical, classification: .wall,
            minimumBounds: SIMD2<Float>(0.6,0.6)))
        let planeMesh = MeshResource.generatePlane(width: 3.75, depth: 2.625, cornerRadius: 0.1)
        let material = SimpleMaterial(color: .red, isMetallic: false)
        let wallEntity = ModelEntity(mesh: planeMesh, materials: [material])
        wallAnchor.addChild(wallEntity)
        return wallAnchor
                                                   
    }()
    
    @State var tableEntity: Entity = {
        let abbyAnchor = AnchorEntity( .plane(.horizontal, classification: .floor,minimumBounds: SIMD2<Float>(0.1,0.1)))
        return abbyAnchor
    }()
        
    var body: some View {
        RealityView { content in
            do {
                let immersiveEntity = try await Entity(named: "Immersive", in: realityKitContentBundle)
                tableEntity.addChild(immersiveEntity)
                content.add(immersiveEntity)
                content.add(wallEntity)
            } catch {
                print("Error error chicken error: \(error)")
            }
        }
    }
}

#Preview {
    ImmersiveView()
        .previewLayout(.sizeThatFits)
}
