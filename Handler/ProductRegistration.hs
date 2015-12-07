module Handler.ProductRegistration where

import Import
import Handler.Home (widgetForm)

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
-- <*> aopt (selectFieldList colors) "Color" (carColor <$> mcar)
--   where
--     colors :: [(Text, Color)]
--     colors = [("Red", Red), ("Blue", Blue), ("Gray", Gray), ("Black", Black)]

-- ProductType
--     Beverage
--     Sandwich
--     Dessert
--     Serving
--     deriving Show


-- Product
--     ident Text x
--     name Text x
--     price Double x
--     productType ProductType
--     UniqueProduct ident
--     deriving Show