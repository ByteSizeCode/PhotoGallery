/*
 * Copyright (C) 2015 - 2016, Daniel Dahan and CosmicMind, Inc. <http://cosmicmind.com>.
 * All rights reserved.
 */

import UIKit
import Material

class AppToolbarController: ToolbarController {
    open override func prepare() {
        super.prepare()
        isMotionEnabled = true
      
        toolbar.depthPreset = .none
        toolbar.dividerColor = Color.grey.lighten2
    }
}
