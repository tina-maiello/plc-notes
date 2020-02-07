import Data.Maybe (isJust)
import Text.Read (readMaybe)
-- teaching haskell a new type
-- the first int is the name of the constructor
-- First type is called Integer and takes an integer "int", so on
data Val = Integer Int
        | Real Float
        | Id String
        deriving(Show)

-- type conversion
strToVal :: String -> Val
strToVal s = case readMaybe s :: Maybe Int of
    -- just i is what we get from the  maybe int. can be the value of the int OR nothing
    -- if we see just i, how do we get it to be our data type..
    -- transfer from maybe to our val, in this case, integer. return integer constructor
    Just i -> Integer i
    -- important thing for cases in FP: all branches must have compatible types. Every branch in this case must have a Val.
    -- must cover all possibilities, including nothing so...
    Nothing -> case readMaybe s :: Maybe Float of
        Just f -> Real f
        Nothing -> Id s

-- we have a super powerful pattern matcher, so lets write an eval function!
-- we want this eval to take a string, (presumably the operator we want to apply) and makes a list of vals on the stack
-- and returns a list of stacks...
-- Remember: first [Val] is the stack during and the second [Val] is the return of the function!
eval :: String -> [Val] -> [Val]
-- going to use this pattern matcher, to match with the ACTUAL VALUE!
-- asserting that in multiplication that we will have 1 real element followed by another real element, followed by  a tail.
-- if the stack does not see that, it won't match, and will not run!
-- now in equals we implement the actual functionality. Do the multiplication and return it to the stack
-- the last statement( in FP is going to be the return always.
eval "*" (Real x:Real y:tl) = Real (x*y) : tl
-- fill in the rest!
-- eval "*" (Integer x:Real y:tl) = Real (x*y) : tl
-- eval "*" (Real x:Real y:tl) = Real (x*y) : tl
-- eval "*" (Real x:Integer y:tl) = Real (x*y) : tl
-- eval "*" (Integer x:Integer y:tl) = Integer (x*y) : tl

-- above rule seemingly works for me on its own?!

-- duplicates the element that is at the top of the stack
eval "DUP"

-- this must be the last rule!
-- catch all, puts on stack and lets others deal with it later!
eval s l = Id s : l

-- Missed explanation a bit but i think this is making a list of words
parse :: String -> [Val]
parse s = let wL = words s in 
        map strToVal wL
