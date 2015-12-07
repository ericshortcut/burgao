{-# LANGUAGE TemplateHaskell #-}

module Import.BillingStatus where
 
import Database.Persist.TH
import Prelude


data BillingStatus =  Open | WaitingPayment | Closed deriving (Show, Eq, Enum, Bounded,Read)

derivePersistField "BillingStatus"