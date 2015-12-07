module Handler.Home where

import Import
import Database.Persist.Postgresql

getHomeR :: Handler Html
getHomeR = do
         (widget,enctype)<-generateFormPost loginForm
         defaultLayout $ widgetForm HomeR enctype widget "Login" "Entrar"

postHomeR :: Handler Html
postHomeR = do
        ((result,_),_) <- runFormPost loginForm
        case result of
            FormSuccess usuarioForm -> do
                user <- runDB $ selectFirstUser usuarioForm
                case user of
                    Just (Entity uid userDB) -> do
                        setSession "_ID" $ pack ( show $ fromSqlKey uid)
                        setSession "userName" $ (pack . show . userName)  userDB
                        setSession "userEmail" $ (pack . show . userEmail)  userDB
                        putStrLn $ (pack .show )  uid
                        putStrLn $ (pack .show . userName)  userDB
                        putStrLn $ (pack .show . userEmail)  userDB
                        redirect HomeClientR
                    Nothing -> do
                        setMessage $ [shamlet| Usuário Inválido ou senha inválido(os) |]
                        redirect HomeR 
            _ -> redirect HomeR



loginForm::Form User
loginForm =  renderDivs $ User
                       <$> lift (return "")
                       <*> lift (return "")
                       <*> areq textField "E-mail" Nothing
                       <*> areq passwordField "Senha" Nothing

widgetForm :: Route App -> Enctype -> Widget -> Text -> Text -> Widget
widgetForm getPostAction enctype widget title submitButtonText = do
             message <- getMessage
             $(whamletFile "templates/form.hamlet")

selectFirstUser :: ( MonadIO m ) => User -> ReaderT SqlBackend m (Maybe (Entity User))
selectFirstUser userToSearch = selectFirst [ UserEmail ==. userEmail userToSearch, 
                                             UserPassword ==. userPassword userToSearch ] []
