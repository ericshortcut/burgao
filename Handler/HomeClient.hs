module Handler.HomeClient where

import Import
import Database.Persist.Postgresql

getHomeClientR :: Handler Html
getHomeClientR = do
                userName <- lookupSession "userName"
                case userName of
                    Nothing -> do
                        setMessage "Saiu do sistema"
                        redirect HomeR
                    Just user -> do
                        beverages  <- runDB $ selectList [ProductProductType ==. Beverage] [ Asc ProductId ]
                        sandwiches  <- runDB $ selectList [ProductProductType ==. Sandwich] [ Asc ProductId ]
                        desserts  <- runDB $ selectList [ProductProductType ==. Dessert] [ Asc ProductId ]
                        servings  <- runDB $ selectList [ProductProductType ==. Serving] [ Asc ProductId ]
                        defaultLayout $( whamletFile "templates/homeClient.hamlet" )

postHomeClientR :: Handler Html
postHomeClientR = error "Not yet implemented: postHomeClientR"