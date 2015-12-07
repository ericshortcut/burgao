module Handler.Util where



data Field = FieldName | FieldEmail | FieldPassword 

setUserSession :: User -> ()

setSession uid user = do
                 setSession "_ID" $ (pack . show) uid
                 setSession "userName" $ (pack . show . userName)  userDB
                 setSession "userEmail" $ (pack . show . userEmail)  userDB

getUserSession :: User
getUserSession = User <$> lookupSession "userName" <*> lookupSession "userEmail" <*>