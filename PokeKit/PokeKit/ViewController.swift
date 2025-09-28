//
//  ViewController.swift
//  PokeKit
//
//  Created by Jitesh Dhumal on 27/09/25.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        if let imageTrack = ARReferenceImage.referenceImages(inGroupNamed: "ARResouce", bundle: Bundle.main) {
            configuration.trackingImages = imageTrack
            configuration.maximumNumberOfTrackedImages = 2
            print("Images Successfully Added!!")
        }

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
    func renderer(_ renderer: any SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor {
            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
            
            let planeNode = SCNNode(geometry: plane)
            planeNode.eulerAngles.x = -.pi/2
            node.addChildNode(planeNode)
            
            if imageAnchor.referenceImage.name == "charli" {
                if let pokeScnene = SCNScene(named: "art.scnassets/Lugia.scn") {
                    if let pokeNode = pokeScnene.rootNode.childNodes.first {
                        print("Lugia")
                        pokeNode.scale = SCNVector3(0.0002, 0.0002, 0.0002)
                        pokeNode.position = SCNVector3(0.01, -0.02, 0.02)
                        pokeNode.eulerAngles.y = -.pi/6.3
                        pokeNode.eulerAngles.z = .pi/3
                        pokeNode.eulerAngles.x = .pi/1.8
                        planeNode.addChildNode(pokeNode)
                    }
                }
            }
            
            if imageAnchor.referenceImage.name == "lucario" {
                if let pokeScnene = SCNScene(named: "art.scnassets/Lucario.scn") {
                    if let pokeNode = pokeScnene.rootNode.childNodes.first {
                        print("Lucario")
                        pokeNode.scale = SCNVector3(0.0007, 0.0007, 0.0007)
                        pokeNode.position = SCNVector3(0, 0, 0.03)
                        pokeNode.eulerAngles.y = -.pi/7.3
                        pokeNode.eulerAngles.z = -.pi/7
                        pokeNode.eulerAngles.x = .pi/15.6
                        planeNode.addChildNode(pokeNode)
                    }
                }
            }
        }
        
        return node
    }
}
