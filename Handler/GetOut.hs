module Handler.GetOut where

import Import

getGetOutR :: Handler Html
getGetOutR = do
             deleteSession "_ID"
             redirect HomeR
