module Handler.SignUp where

import Import
import Handler.Home (widgetForm)
import Data.Time
import Data.Time.Clock.POSIX
import System.IO.Unsafe

getSignUpR :: Handler Html
getSignUpR = do
         (widget,enctype)<-generateFormPost loginForm
         defaultLayout $ widgetForm SignUpR enctype widget "Formulário de Cadastro" "Enviar"

postSignUpR :: Handler Html
postSignUpR = do
        ((result,_),_) <- runFormPost loginForm
        case result of
            FormSuccess user -> do
                _ <- runDB $ insert user
                setMessage $ [shamlet| Cadastrado com Sucesso #{userName user} |]
                redirect HomeR 
            _ -> do
                setMessage $ [shamlet| Ocorreu algum problema, favor checar!|]
                redirect SignUpR


loginForm::Form User
loginForm =  renderDivs $ User
                       <$> (lift (return (pack ccid)))
                       <*> areq textField "Nome" Nothing
                       <*> areq textField "E-mail" Nothing
                       <*> areq passwordField "Senha" Nothing
                       where ccid = ( show (unsafePerformIO getPOSIXTime))

