-------------------------------------------------------------------------------
-- | Module      :  System.RCB.Plugins.RSS.RssConfig.PushDescriptors
--   Copyright   :  (c) Matthias Brettschneider 2019
--   License     :  as-is
--
--   Maintainer  :  frosch03@gmail.com
--   Stability   :  unstable
--   Portability :  unportable
--
-------------------------------------------------------------------------------

module System.RCB.Plugins.RSS.RssConfig.PushDescriptors
where

import System.RCB.Room
import System.RCB.Plugins.RSS.RssConfig.FeedDescriptor

-- Datatype
data PushDescriptors
    = Push
      { pushFeedIntoRoomss :: [(FeedDescriptor, [Room])]
      , pushInterval       :: Int
      }
    deriving (Show, Read, Eq)
