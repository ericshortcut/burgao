module Handler.Buy where

import Import
import Database.Persist.Postgresql
import Prelude as P

getBuyR :: ProductId -> Handler Html
getBuyR productId = do
                clientId <- lookupSession "_ID"
                case clientId of 
                    Just cid -> do
                        -- _ <- runDB $ insert (genData cid)
                        return "Produto adicionado"
                    _ -> redirect HomeR

                    -- where idTransform c = ((show c)::Int)
                          -- genData b = (Buy productId  (toSqlKey (idTransform b)) Open)


