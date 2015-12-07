module Handler.Buy where

import Import
import Database.Persist.Postgresql
import Prelude as P

getBuyR :: ProductId -> Handler Html
getBuyR productId = do
                clientId <- lookupSession "_ID"
                case clientId of 
                    Just cid -> do
                        _ <- runDB $ insert (Buy productId  (toSqlKey (idTransform cid)) Open)
                        return "Produto adicionado"
                    _ -> redirect HomeR

                    where idTransform c = P.read (show c)::Int64