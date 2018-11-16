{-|
File: classic.hs
Author: Jacob Komissar
Date: 2018-11-15

So, you say your favorite part of Haskell is that it doesn't have variables and
an 'if' statement? We'll see about that!
-}
import Data.Char (toLower)

main = do
  name <- askName
  putStrLn $ "Hello, " ++ name ++ "!"

askName = do
  putStrLn "What is your name?"
  name <- getLine
  done <- confirm $ "Is your name '" ++ name ++ "'?"
  if done
    then return name
    else askName -- try again

confirm prompt = do
  putStrLn prompt
  let response = "default"
  response <- getLine
  -- Instead of checking all of the cases, just lowercase the input
  response <- strToLower response
  if response `elem` ["y", "yes"]
    then return True
    else if response `elem` ["n", "no"]
    then return False
    else do putStrLn "Please answer 'y[es]' or 'n[o]'."
            confirm prompt

strToLower string =
  if (null string)
  then return ""
  else do
    -- Break up the string
    let first = head string
    let rest = tail string
    -- Make the parts lowercase
    first <- toLowerCS first
    rest <- strToLower rest
    -- Stick the lowercased parts back together
    return (first : rest)

toLowerCS c =
  return (toLower c)
