{-# LANGUAGE TemplateHaskell #-}

module Import.ProductType where
 
import Database.Persist.TH
import Prelude


data ProductType =  Beverage | Sandwich | Dessert | Serving deriving (Show, Eq, Enum, Bounded,Read)

derivePersistField "ProductType"