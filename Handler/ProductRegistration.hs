module Handler.ProductRegistration where

import Import
import Handler.Home (widgetForm)
import Database.Persist.Postgresql

getProductRegistrationR :: Handler Html
getProductRegistrationR = do
         (widget,enctype)<-generateFormPost productForm
         defaultLayout $ widgetForm ProductRegistrationR enctype widget "Cadastrar" "Cadastrar"

postProductRegistrationR :: Handler Html
postProductRegistrationR = do
            ((result,_),_) <- runFormPost productForm
            case result of
                FormSuccess prod -> do
                    _ <- runDB $ insert prod
                    setMessage $ [shamlet| Cadastrado com Sucesso #{ productName prod } |]
                    redirect ProductRegistrationR 
                _ -> do
                    setMessage $ [shamlet| Ocorreu algum problema, favor checar!|]
                    redirect ProductRegistrationR


productForm :: Form Product
productForm =  renderDivs $ Product 
          <$> areq textField "Nome" Nothing 
          <*> areq doubleField "Preço" Nothing 
          <*> areq (selectFieldList pts) "Depto" Nothing
          where 
            pts::[(Text,ProductType)]
            pts = [("Bebiba",Beverage),("Sanduíche",Sandwich),("Sobremesa",Dessert),("Porção",Serving)]
