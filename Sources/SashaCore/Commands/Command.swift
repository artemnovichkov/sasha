//
//  Copyright © 2017 Artem Novichkov. All rights reserved.
//

import Utility

public protocol Command {
    var command: String { get }
    var overview: String { get }

    init(parser: ArgumentParser)
    func run(with arguments: ArgumentParser.Result) throws
}
