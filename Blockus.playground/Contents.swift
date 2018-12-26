//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

protocol Settable {}
extension Settable {
    func setting<Value>(path keyPath: WritableKeyPath<Self, Value>, to value: Value) -> Self {
        var mutableSelf = self
        mutableSelf[keyPath: keyPath] = value
        return mutableSelf
    }
    
    func setting<Value>(path keyPath: WritableKeyPath<Self, Value>, using modification: (Value) -> Value) -> Self {
        return setting(path: keyPath, to: modification(self[keyPath: keyPath]))
    }
}

extension Int {
    static func incr(_ x: Int) -> Int {
        return x + 1
    }
    
    static func decr(_ x: Int) -> Int {
        return x - 1
    }
}

enum Color: Equatable {
    case blue
    case green
    case yellow
    case red
}

extension UIColor {
    
    static func color(for color: Color) -> UIColor {
        switch color {
        case .blue: return .blue
        case .green: return .green
        case .yellow: return .yellow
        case .red: return .red
        }
    }
}

extension Character {
    
    static func color(for color: Color) -> Character {
        switch color {
        case .blue: return "B"
        case .green: return "G"
        case .yellow: return "Y"
        case .red: return "R"
        }
    }
}

enum Tile: Equatable {
    case blank
    case occupied(Color)
    
    var color: Color? {
        guard case let .occupied(color) = self else { return nil }
        return color
    }
}

struct Coordinate: Hashable, Settable {
    var x: Int
    var y: Int
    
    func offset(by offset: Coordinate) -> Coordinate {
        return self
            .setting(path: \.x) { x in x + offset.x }
            .setting(path: \.y) { y in y + offset.y }
    }
}

extension Coordinate {
    
    var above: Coordinate { return Coordinate.above(self) }
    var below: Coordinate { return Coordinate.below(self) }
    var left: Coordinate { return Coordinate.left(of: self) }
    var right: Coordinate { return Coordinate.right(of: self) }
    
    static func above(_ other: Coordinate) -> Coordinate {
        return other.setting(path: \Coordinate.y, using: Int.decr)
    }
    
    static func below(_ other: Coordinate) -> Coordinate {
        return other.setting(path: \Coordinate.y, using: Int.incr)
    }
    
    static func left(of other: Coordinate) -> Coordinate {
        return other.setting(path: \Coordinate.x, using: Int.decr)
    }
    
    static func right(of other: Coordinate) -> Coordinate {
        return other.setting(path: \Coordinate.x, using: Int.incr)
    }
}

extension Coordinate {
    
    static func upperLeft(of other: Coordinate) -> Coordinate {
        return above(left(of: other))
    }
    
    static func upperRight(of other: Coordinate) -> Coordinate {
        return above(right(of: other))
    }
    
    static func lowerLeft(of other: Coordinate) -> Coordinate {
        return below(left(of: other))
    }
    
    static func lowerRight(of other: Coordinate) -> Coordinate {
        return below(right(of: other))
    }
}

extension Coordinate {
    
    func reflected(on axis: Axis, at point: Coordinate) -> Coordinate {
        return Coordinate.reflect(self, on: axis, at: point)
    }
    
    static func reflect(_ coordinate: Coordinate, on axis: Axis, at point: Coordinate) -> Coordinate {
        
        switch axis {
        case .horizontal:
            let distance = point.x - coordinate.x
            return coordinate.setting(path: \.x, to: point.x + distance)
            
        case .vertical:
            let distance = point.y - coordinate.y
            return coordinate.setting(path: \.y, to: point.y + distance)
        }
    }
}

struct Size {
    var width: Int
    var height: Int
    
    var topLeft: Coordinate { return Coordinate(x: 0, y: 0) }
    var topRight: Coordinate { return Coordinate(x: width - 1, y: 0) }
    var bottomLeft: Coordinate { return Coordinate(x: 0, y: height - 1) }
    var bottomRight: Coordinate { return Coordinate(x: width - 1, y: height - 1) }
    var center: Coordinate { return Coordinate(x: width / 2, y: height / 2) }
}

class Board: Settable {
    
    private var grid: [[Tile]]
    let size: Size
    
    init(size: Size = Size(width: 20, height: 20)) {
        
        self.size = size
        
        grid = [[Tile]](
            repeating: [Tile](
                repeating: .blank,
                count: size.width
            ),
            count: size.height
        )
    }
    
    func tile(at coordinate: Coordinate) throws -> Tile {
        
        try Board.validate(coordinate: coordinate, existsOn: self)
        return grid[coordinate.x][coordinate.y]
    }
    
    var coordinates: [Coordinate] {
        return (0 ..< size.width).flatMap { x in
            (0 ..< size.height).map { y in Coordinate(x: x, y: y) }
        }
    }
    
    func indexedTiles() -> [(coord: Coordinate, tile: Tile)] {
        return grid.enumerated().flatMap { column in
            column.element.enumerated().map { tile in (Coordinate(x: column.offset, y: tile.offset), tile.element) }
        }
    }
}

extension Board {
    
    static func validate(coordinate: Coordinate, existsOn board: Board) throws {
        
        guard coordinate.x < board.size.width && coordinate.y < board.size.height else {
            throw Error.invalidCoordinate(coordinate)
        }
    }
    
    static func validate(coordinate: Coordinate, isVacantOn board: Board) throws {
        
        let tile = try board.tile(at: coordinate)
        switch tile {
        case .occupied(let color):
            throw Error.itemExists(color: color, coord: coordinate)
        case .blank:
            break
        }
    }
}

extension Board {
    
    func placeTile(of color: Color, at coordinate: Coordinate) throws -> Board {
        
        try Board.validate(coordinate: coordinate, existsOn: self)
        try Board.validate(coordinate: coordinate, isVacantOn: self)
        return self.setting(path: \.grid[coordinate.x][coordinate.y], to: .occupied(color))
    }
    
    func remoteTile(at coordinate: Coordinate) throws -> Board {
        
        try Board.validate(coordinate: coordinate, existsOn: self)
        return self.setting(path: \.grid[coordinate.x][coordinate.y], to: .blank)
    }
    
    func place(piece: Piece, at coordinate: Coordinate) throws -> Board {
        
        return try piece.coordinates
            .map { $0.offset(by: coordinate) }
            .reduce(board) { board, coord in try board.placeTile(of: piece.color, at: coord) }
    }
}

extension Board {
    
    enum Error: Swift.Error {
        case itemExists(color: Color, coord: Coordinate)
        case invalidCoordinate(Coordinate)
    }
}

struct Piece: Settable {
    
    var coordinates: Set<Coordinate>
    let size: Size
    let numberOfPieces: Int
    let color: Color
    
    init(coordinates: [Coordinate], color: Color) {
        
        self.coordinates = Set(coordinates)
        self.color = color
        
        size = Piece.calculateSize(of: coordinates)
        numberOfPieces = self.coordinates.count
    }
    
    init(string: String, color: Color) {
        
        var coordinates = [Coordinate]()
        
        let lines = string.split(separator: "\n")
        for (y, line) in lines.enumerated() {
            for (x, tile) in line.enumerated() where tile != " " {
                let coord = Coordinate(x: x, y: y)
                coordinates.append(coord)
            }
        }
        
        self.init(coordinates: coordinates, color: color)
    }
    
    static func calculateSize(of coordinates: [Coordinate]) -> Size {
        let xValues = coordinates.map { $0.x }
        let yValues = coordinates.map { $0.y }
        
        return Size(
            width: (xValues.max() ?? 0) - (xValues.min() ?? 0),
            height: (yValues.max() ?? 0) - (yValues.min() ?? 0)
        )
    }
}

enum Axis {
    case horizontal
    case vertical
}

extension Piece {
    
    func normalized() -> Piece {
        return Piece.normalize(self)
    }

    static func normalize(_ piece: Piece) -> Piece {

        let minX = piece.coordinates.map { $0.x }.min() ?? 0
        let minY = piece.coordinates.map { $0.y }.min() ?? 0
        
        let offset = Coordinate(x: -minX, y: -minY)
        return piece.setting(path: \Piece.coordinates) { coords in
            Set(coords.map { $0.offset(by: offset) })
        }
    }

    func mirrored(on axis: Axis) -> Piece {
        return Piece.mirror(self, axis: axis)
    }
    
    static func mirror(_ piece: Piece, axis: Axis) -> Piece {
        
        let newPiece = piece.setting(path: \Piece.coordinates) { coords in
            Set(coords.map { coord in coord.reflected(on: axis, at: piece.size.center) })
        }
        
        return normalize(newPiece)
    }
}

class BoardView: UIView {
    
    static let defaultFrame = CGRect(x: 0, y: 0, width: 600, height: 600)
    static let defaultMargin: CGFloat = 2
    
    var board: Board {
        didSet { setNeedsDisplay() }
    }
    
    init(board: Board, frame: CGRect = BoardView.defaultFrame) {
        self.board = board
        super.init(frame: frame)
    }
    
    override func draw(_ rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        
        for (coordinate, tile) in board.indexedTiles() {
            
            let frame = self.rect(for: coordinate, boardSize: board.size)
            let color = tile.color.flatMap(UIColor.color) ?? .lightGray
            
            color.setFill()
            context?.fill(frame)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BoardView {
    
    private func cellSize(
        forBoardSize boardSize: Size,
        margin: CGFloat = BoardView.defaultMargin
    ) -> CGSize {
        
        let collectiveHorizontalMargin = CGFloat(boardSize.width + 1) * margin
        let collectiveVerticalMargin = CGFloat(boardSize.height + 1) * margin
        
        return CGSize(
            width: (bounds.width - collectiveHorizontalMargin) / CGFloat(boardSize.width),
            height: (bounds.height - collectiveVerticalMargin) / CGFloat(boardSize.height)
        )
    }
    
    private func rect(
        for coordinate: Coordinate,
        boardSize: Size,
        margin: CGFloat = BoardView.defaultMargin
    ) -> CGRect {
        
        let size = self.cellSize(forBoardSize: boardSize, margin: margin)
        
        let origin = CGPoint(
            x: margin + (size.width + margin) * CGFloat(coordinate.x),
            y: margin + (size.height + margin) * CGFloat(coordinate.y)
        )
        
        return CGRect(origin: origin, size: size)
    }
}

var board = Board(size: Size(width: 20, height: 20))
let boardView = BoardView(board: board)

PlaygroundPage.current.liveView = boardView

let piece = Piece(
    string: """
            XXX
            XX
             X
            """,
    color: .red
)

let bluePiece = Piece(
    string: """
             X
             X
            XX
            """,
    color: .blue
)

boardView.board = try board
    .place(piece: piece, at: Coordinate(x: 5, y: 5))
    .place(piece: bluePiece, at: Coordinate(x: 0, y: 0))
