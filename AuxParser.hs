module AuxParser
where

import Text.ParserCombinators.Parsec
  
pBool :: GenParser Char st Bool
pBool
    =     (string "true"  >> return True)
      <|> (string "True"  >> return True)
      <|> (string "false" >> return False)
      <|> (string "False" >> return False)

pBoolOfKey :: String -> GenParser Char st Bool
pBoolOfKey key = do
  string $ "\"" ++ key ++ "\":"
  s <- pBool
  return (s)

pQuotedString :: GenParser Char st String
pQuotedString
    = do char '\"'
         xs  <- many1 $ noneOf "\""
         char '\"'
         return $ xs
           
pInt :: GenParser Char st Int
pInt
    = do try ( do (char '-')
                  ds <- many digit
                  return (-1 * (read ds))
             )
         <|> ( do ds <- many digit
                  return ((read ds))
             )

pValOfKey :: String -> GenParser Char st String
pValOfKey key = do
  string $ "\"" ++ key ++ "\":"
  s <- pQuotedString
  return (s)

pValOfParams :: (GenParser Char st a) -> GenParser Char st [a]
pValOfParams parser = do
  string "\"params\":["
  xs <- sepBy parser (char ',')
  char ']'
  return xs

pKeyVal :: (String, String) -> GenParser Char st ()
pKeyVal (key, val) = do
  string $ "\"" ++ key ++ "\":"
  string $ "\"" ++ val ++ "\""
  return ()

pUsernameFromFields :: GenParser Char st String
pUsernameFromFields = do
  string $ "\"fields\":"      ; char '{'
  user <- pValOfKey "username" ; char ','
  string "\"emails\":" 
  many1 (noneOf "]")          ; char ']'
  char '}'
  return user
