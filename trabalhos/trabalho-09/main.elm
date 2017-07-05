import Html exposing (text)

type alias Env = (String -> Int)
ambInicial : Env
ambInicial = \ask -> 0

--Exp
type Exp = Add Exp Exp
         |Sub Exp Exp
         |Mul Exp Exp
         |Div Exp Exp
         |Pot Exp Exp
         | Num Int
         | Var String

evalExp : Exp -> Env -> Int
evalExp exp env =
    case exp of
        Add exp1 exp2  -> (evalExp exp1 env) + (evalExp exp2 env) 
        Sub exp1 exp2 -> (evalExp exp1 env) - (evalExp exp2 env) 
        Mul exp1 exp2 -> (evalExp exp1 env) * (evalExp exp2 env)
        Div exp1 exp2 -> (evalExp exp1 env) // (evalExp exp2 env)
        Pot exp1 exp2 -> (evalExp exp1 env) ^ (evalExp exp2 env) 
        Num v             -> v
        Var var            -> (env var)
        
--Prog  
type Prog = Attr String Exp
          | Seq Prog Prog
          | If Exp Prog Prog
          | While Exp Prog Prog

evalProg : Prog -> Env -> Env
evalProg s env =
    case s of
        Seq s1 s2 -> 
            (evalProg s2 (evalProg s1 env))
            
        Attr var exp -> 
            let
                val = (evalExp exp env)
            in
                \ask -> if ask==var then val else (env ask)
                
        If exp pTrue pFalse -> 
             evalProg (if (evalExp exp env) == 0 then pTrue 
                      else pFalse) env
                 
        While exp pTrue pFalse -> 
            if (evalExp exp env > 0) then 
                evalProg (While exp pTrue pFalse) (evalProg pTrue env) 
            else 
                evalProg pFalse env
            

lang : Prog -> Int
lang p = ((evalProg p ambInicial) "ret") 
        
p1 : Prog
p1 = (Attr "ret" (Add (Num 11) (Num 9)))

p2 : Prog
p2 = Seq
        (Attr "x"   (Num 11))
        (Attr "ret" (Add (Var "x") (Num 9)))
        
p3 : Prog 
p3 = If (Num 0) 
        (Attr "ret" (Add (Num 12) (Num 6) ))
        (Attr "ret" (Div (Num 40) (Num 5) )) 
        
p4 : Prog 
p4 = Seq 
        (Seq (Attr "x" (Num 0)) (Attr "contador" (Num 5)) )
        (While (Var "contador") --Enquanto cont > 0
            (Seq (Attr "x" (Add (Var "x") (Num 2))) (Attr "contador" (Sub (Var "contador") (Num 1))) )
            (Attr "ret" (Var "x")) 
        )

main = text (toString (lang p4))
