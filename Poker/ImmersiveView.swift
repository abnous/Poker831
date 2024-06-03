//
//  ImmersiveView.swift
//  Poker
//
//  Created by Abby Nayeri  on 2024-05-30.
//

import SwiftUI
import RealityKit
import RealityKitContent
import UIKit
import SceneKit
import ARKit

class ImmersiveView: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene
        
        // Add a tap gesture recognizer
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Enable horizontal plane detection
        configuration.planeDetection = [.horizontal]
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    @objc func handleTap(_ gestureRecognize: UIGestureRecognizer) {
        // Get the current frame
        let sceneView = gestureRecognize.view as! ARSCNView
        let touchLocation = gestureRecognize.location(in: sceneView)
        
        // Perform a hit test
        let hitTestResults = sceneView.hitTest(touchLocation, types: .existingPlaneUsingExtent)
        
        if let result = hitTestResults.first {
            // Get the position of the hit test result
            let position = SCNVector3(
                x: result.worldTransform.columns.3.x,
                y: result.worldTransform.columns.3.y,
                z: result.worldTransform.columns.3.z
            )
            
            // Create a sphere geometry
            let sphere = SCNSphere(radius: 0.05)
            
            // Create a node with the sphere geometry
            let sphereNode = SCNNode(geometry: sphere)
            
            // Set the position of the node
            sphereNode.position = position
            
            // Add the node to the scene
            sceneView.scene.rootNode.addChildNode(sphereNode)
        }
    }
}



struct ImmersiveView: View {
    var body: some View {
        RealityView { content in
            if let pokerModel = try? await Entity(named: "pokertable"),
               let pokertable = pokerModel.children.first?.children.first{
                pokertable.scale = [0.1,0.1,0.1]
                pokertable.position.x = 0
                pokertable.position.y = 0
                pokertable.position.z = 1
       content.add(pokertable)
            }
        }
    }
}

#Preview(immersionStyle: .full) {
    ImmersiveView()
}
