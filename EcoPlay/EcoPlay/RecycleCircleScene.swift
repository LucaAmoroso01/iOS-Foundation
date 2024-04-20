//
//  RecycleCircleScene.swift
//  EcoPlay
//
//  Created by Rocco Del Prete on 17/04/2024.
//

import SpriteKit
import SwiftUI

struct ObjectCategories {
    static let objectCategory = UInt32(16)
}

struct WasteTypesCategories {
    static let organic: UInt32 = 0b0
    static let plastic: UInt32 = 0b1
    static let paper: UInt32 = 0b10
    static let mixed: UInt32 = 0b11
}

struct WasteObject {
    let wasteObjectType: UInt32
    let wasteObject: SKSpriteNode
    let name: String
    let wasteObjectName: String
}

struct Popup {
    var popupShape: SKShapeNode = SKShapeNode()
    var popupBackground: SKNode = SKSpriteNode()
    var popupText: SKLabelNode = SKLabelNode()
    var lampadino: SKSpriteNode = SKSpriteNode()
    
    init(popupShape: SKShapeNode, popupBackground: SKNode, popupText: SKLabelNode, lampadino: SKSpriteNode) {
        self.popupShape = popupShape
        self.popupBackground = popupBackground
        self.popupText = popupText
        self.lampadino = lampadino
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0.0, y: 30.0))
        path.addLine(to: CGPoint(x: 30.0, y: -16.6))
        path.addLine(to: CGPoint(x: -30.0, y: -16.6))
        path.addLine(to: CGPoint(x: 0.0, y: 30.0))
        let triangle = SKShapeNode(path: path.cgPath)
        triangle.fillColor = UIColor.white
        triangle.position = CGPoint(x: -170, y: -433)
        triangle.zRotation = -0
        
        self.popupShape.addChild(popupText)
        self.popupShape.addChild(lampadino)
        self.popupShape.addChild(triangle)
        
        self.popupShape.run(SKAction.move(by: CGVector(dx: 0, dy: -30), duration: 0.8))
        
        self.popupBackground.addChild(self.popupShape)
    }
}

struct DefaultPopupSizes {
    static let width: Double = 450
    static let height: Double = 150
}

class RecycleCircleScene: SKScene, SKPhysicsContactDelegate, ObservableObject {
    private var wasteObjects = [
        WasteObject.init(wasteObjectType: (WasteTypesCategories.plastic), wasteObject: SKSpriteNode(imageNamed: "plastic-bottle"), name: "plastic", wasteObjectName: "plastic bottle"),
        WasteObject.init(wasteObjectType: (WasteTypesCategories.organic), wasteObject: SKSpriteNode(imageNamed: "ice-cream"), name: "organic", wasteObjectName: "ice cream"),
        WasteObject.init(wasteObjectType: (WasteTypesCategories.plastic), wasteObject: SKSpriteNode(imageNamed: "tin-can"), name: "plastic", wasteObjectName: "tin can"),
        WasteObject.init(wasteObjectType: (WasteTypesCategories.paper), wasteObject: SKSpriteNode(imageNamed: "paper"), name: "paper", wasteObjectName: "paper sheets"),
        WasteObject.init(wasteObjectType: (WasteTypesCategories.paper), wasteObject: SKSpriteNode(imageNamed: "cardboard"), name: "paper", wasteObjectName: "cardboard"),
        WasteObject.init(wasteObjectType: (WasteTypesCategories.mixed), wasteObject: SKSpriteNode(imageNamed: "dirty-cardboard"), name: "mixed", wasteObjectName: "dirty cardboard"),
        WasteObject.init(wasteObjectType: (WasteTypesCategories.mixed), wasteObject: SKSpriteNode(imageNamed: "markers"), name: "mixed", wasteObjectName: "markers"),
        WasteObject.init(wasteObjectType: (WasteTypesCategories.mixed), wasteObject: SKSpriteNode(imageNamed: "pencils"), name: "mixed", wasteObjectName: "pencils"),
        WasteObject.init(wasteObjectType: (WasteTypesCategories.mixed), wasteObject: SKSpriteNode(imageNamed: "pizza-cardboard"), name: "mixed", wasteObjectName: "pizza cardboard"),
        WasteObject.init(wasteObjectType: (WasteTypesCategories.paper), wasteObject: SKSpriteNode(imageNamed: "wastepaper"), name: "paper", wasteObjectName: "wastepaper"),
        WasteObject.init(wasteObjectType: (WasteTypesCategories.organic), wasteObject: SKSpriteNode(imageNamed: "banana-peel"), name: "organic", wasteObjectName: "banana peel"),
    ]
    
    private var popups: [String:Popup] = [:]
    private var currentPopup: String?
    
    private var currentWasteObject: WasteObject?
    private var currentWasteIndex: Int = 0
    
    @Published var isGameEnded = false
    
    override func sceneDidLoad() {
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = .zero
    }
    
    override func didMove(to view: SKView) {
        loadLabels()
        loadWasteObject()
        
        createPopup(text: "Hi I'm Lampadino and I'll assist you to recycle some wastes.", textPosition: CGPoint(x: 50, y: -431), name: "first")
        createPopup(text: "You learned how to recycle! Test your skills with the game!", textPosition: CGPoint(x: 50, y: -426), name: "last")
        createPopup(text: "Good job little hero!", textPosition: CGPoint(x: 50, y: -390), name: "win")
        createPopup(text: "This is the first waste", textPosition: CGPoint(x: 50, y: -390), name: "firstWaste")
        createPopup(text: "First object to recycle is \"\(String(currentWasteObject!.wasteObjectName))\"", textPosition: CGPoint(x: 50, y: -400), name: "firstWasteSpawned")
        createPopup(text: "Drag it to correct material type to recycle it", textPosition: CGPoint(x: 50, y: -427), name: "drag")
        createPopup(text: "You missed the right choice. This waste went into \(String(describing: currentWasteObject!.name)). Let's try with another one!", textPosition: CGPoint(x: 50, y: -428), name: "lose", popupSize: CGSize(width: 450, height: 190))
        
        showPopupInOrderOnTap()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let positionInScene = touch.location(in: self)
        let nodeTouched = self.atPoint(positionInScene)
        
        if nodeTouched.name == "popupBackground" {
            closePopup(name: currentPopup!)
            showPopupInOrderOnTap()
            
            if (wasteObjects.count == 0) && (currentPopup == "win" || currentPopup == "lose") {
                displayPopup(popupName: "last")
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let positionInScene = touch.location(in: self)
        let nodeTouched = self.atPoint(positionInScene)
        
        if wasteObjects.count > 0 {
            if nodeTouched.name == wasteObjects[currentWasteIndex].wasteObject.name {
                nodeTouched.position = positionInScene
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if ((contact.bodyA.node?.name?.contains((contact.bodyB.node?.name)!))!) {
            win(node: (contact.bodyA.node?.name)!)
        } else {
            lose(node: (contact.bodyA.node?.name)!)
        }
    }
    
    func mutateLabel(labelRefName: String, text: String, fontSize: CGFloat) -> SKNode {
        let label = SKLabelNode(text: text.uppercased())
        label.name = labelRefName
        label.fontName = UIFont.systemFont(ofSize: fontSize, weight: .bold).rounded.fontName
        label.fontSize = fontSize
        label.fontColor = UIColor(Color.darkGreen)
        
        return label
    }
    
    func loadWasteObject() {
        if wasteObjects.count > 0 {
            let randomIndex = Int.random(in: 0..<wasteObjects.count)
            let randomWaste = wasteObjects[randomIndex]
            currentWasteObject = randomWaste
            currentWasteIndex = randomIndex
            
            randomWaste.wasteObject.name = randomWaste.name
            randomWaste.wasteObject.position = CGPoint(x: 0, y: 0)
            randomWaste.wasteObject.size = CGSize(width: 200, height: 100)
            randomWaste.wasteObject.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 100, height: 100))
            randomWaste.wasteObject.physicsBody?.categoryBitMask = randomWaste.wasteObjectType
            randomWaste.wasteObject.physicsBody?.collisionBitMask = UInt32(0)
            randomWaste.wasteObject.physicsBody!.isDynamic = true
            randomWaste.wasteObject.physicsBody!.affectedByGravity = false
            randomWaste.wasteObject.physicsBody?.contactTestBitMask = WasteTypesCategories.plastic
            randomWaste.wasteObject.zPosition = 5
            
            let wasteShape = SKSpriteNode(imageNamed: "gradient-background")
            wasteShape.position = CGPoint(x: randomWaste.wasteObject.position.x, y: randomWaste.wasteObject.position.y)
            
            wasteShape.addChild(randomWaste.wasteObject)
            self.addChild(wasteShape)
        }
    }
    
    func loadLabels() {
        let organicLabel = mutateLabel(labelRefName: "organicLabel", text: "organic", fontSize: 42)
        organicLabel.position = CGPoint(x: -185, y: 320)
        organicLabel.physicsBody = SKPhysicsBody(rectangleOf: (organicLabel.frame.size))
        organicLabel.physicsBody?.contactTestBitMask = ObjectCategories.objectCategory
        organicLabel.physicsBody?.collisionBitMask = UInt32(0)
        organicLabel.physicsBody?.affectedByGravity = false
        self.addChild(organicLabel)
        
        let plasticLabel = mutateLabel(labelRefName: "plasticLabel", text: "plastic", fontSize: 42)
        plasticLabel.position = CGPoint(x: -185, y: -340)
        plasticLabel.physicsBody = SKPhysicsBody(rectangleOf: (plasticLabel.frame.size))
        plasticLabel.physicsBody?.contactTestBitMask = ObjectCategories.objectCategory
        plasticLabel.physicsBody?.collisionBitMask = UInt32(0)
        plasticLabel.physicsBody?.affectedByGravity = false
        self.addChild(plasticLabel)
        
        let paperLabel = mutateLabel(labelRefName: "paperLabel", text: "paper", fontSize: 42)
        paperLabel.position = CGPoint(x: 185, y: 320)
        paperLabel.physicsBody = SKPhysicsBody(rectangleOf: (paperLabel.frame.size))
        paperLabel.physicsBody?.contactTestBitMask = ObjectCategories.objectCategory
        paperLabel.physicsBody?.collisionBitMask = UInt32(0)
        paperLabel.physicsBody?.affectedByGravity = false
        self.addChild(paperLabel)
        
        let mixedLabel = mutateLabel(labelRefName: "mixedLabel", text: "mixed", fontSize: 42)
        mixedLabel.position = CGPoint(x: 185, y: -340)
        mixedLabel.physicsBody = SKPhysicsBody(rectangleOf: (mixedLabel.frame.size))
        mixedLabel.physicsBody?.contactTestBitMask = ObjectCategories.objectCategory
        mixedLabel.physicsBody?.collisionBitMask = UInt32(0)
        mixedLabel.physicsBody?.affectedByGravity = false
        self.addChild(mixedLabel)
    }
    
    func removeWasteNode(node nodeToRemove: String) {
        wasteObjects[currentWasteIndex].wasteObject.removeFromParent()
        wasteObjects.remove(at: currentWasteIndex)
    }
        
    func displayPopup(popupName: String) {
        currentPopup = popupName
        self.addChild(self.popups[popupName]!.popupBackground)
    }
    
    func createPopup(text: String, textPosition: CGPoint, name: String, popupSize: CGSize = CGSize(width: DefaultPopupSizes.width, height: DefaultPopupSizes.height)) {
        
        let popupBackground = SKSpriteNode(color: UIColor(Color.darkGreen.opacity(0.5)), size: CGSize(width: frame.width, height: frame.height))
        popupBackground.zPosition = 80
        popupBackground.name = "popupBackground"
        
        let popup = SKShapeNode(rect: CGRect(origin: CGPoint(x: -170, y: -450), size: CGSize(width: popupSize.width, height: popupSize.height)), cornerRadius: 35)
        popup.fillColor = UIColor(Color.white)
        popup.lineWidth = 0
        popup.zPosition = 50
        popup.name = name
        popup.zPosition = 100
        
        let popupText = SKLabelNode(text: text)
        popupText.fontColor = UIColor(Color.darkGreen)
        popupText.fontName = UIFont.systemFont(ofSize: 32, weight: .bold).rounded.fontName
        popupText.position = textPosition
        popupText.numberOfLines = 0
        popupText.lineBreakMode = .byWordWrapping
        popupText.preferredMaxLayoutWidth = 350
        popupText.zPosition = 100
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0.0, y: 30.0))
        path.addLine(to: CGPoint(x: 30.0, y: -16.6))
        path.addLine(to: CGPoint(x: -30.0, y: -16.6))
        path.addLine(to: CGPoint(x: 0.0, y: 30.0))
        let triangle = SKShapeNode(path: path.cgPath)
        triangle.fillColor = UIColor.white
        triangle.position = CGPoint(x: -170, y: -433)
        triangle.zRotation = -0
        
        let lampadino = SKSpriteNode(texture: SKTexture(image: UIImage(named: "lampadino")!))
        lampadino.position = CGPoint(x: -230, y: -450)
        lampadino.size = CGSize(width: 200, height: 200)
        lampadino.zPosition = 110
        
        popups[name] = .init(popupShape: popup, popupBackground: popupBackground, popupText: popupText, lampadino: lampadino)
        popups[name]?.popupShape.name = name
    }
    
    func win(node nodeToRemove: String) {
        displayPopup(popupName: "win")
        removeWasteNode(node: nodeToRemove)
        loadWasteObject()
    }
    
    func lose(node nodeToRemove: String) {
        displayPopup(popupName: "lose")
        removeWasteNode(node: nodeToRemove)
        loadWasteObject()
    }
    
    func closePopup(name: String) {
        popups[name]?.popupBackground.removeFromParent()
    }
    
    func showPopupInOrderOnTap() {
        switch currentPopup {
        case nil:
            displayPopup(popupName: "first")
        case "first":
            displayPopup(popupName: "firstWaste")
        case "firstWaste":
            displayPopup(popupName: "firstWasteSpawned")
        case "firstWasteSpawned":
            displayPopup(popupName: "drag")
        case "last":
            isGameEnded.toggle()
        default:
            closePopup(name: currentPopup!)
        }
    }
}

extension UIFont {
    var rounded: UIFont {
        guard let desc = self.fontDescriptor.withDesign(.rounded)
        else { return self }
        return UIFont(descriptor: desc, size: self.pointSize)
    }
}

