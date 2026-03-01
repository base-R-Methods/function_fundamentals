# Writing Functions in R
# Named Parameters and Default Parameters
# The “Gobble Up Everything Else” Parameter: “...”
# Functions Don’t Have Names
# Lazy Evaluation
# Functions Don’t Have Names
# Vectorized Functions
# User-defined Infix Operators
# Replacement Functions  

################################################################################

# Writing Functions in R

square <- function(x){
  x^2
}
square(x = 2)

square <- function(x) x^2
square(x = 2)


square <- \(x){
  x^2
}
square(x = 2)

rescale <- function(x){ # 
  m <- mean(x)
  s <- sd(x)
  (x-m)/s
}

body(rescale)
formals(rescale)
environment(rescale)

rescale(x = 1:10)
rescale(1:10)

expr <- quote(3 + 5)
expr
eval(expr)
str(expr)

square <- function(x){
  
  t <- x^2
  return(t) # exit
}
square(x = 2)

square <- function(x){
  
  t <- x^2
  return(t) # exit
}
square(x = 2)


rescale <- function(x , only_translated) {
  m <- mean(x)
  translated <- x-m
  if (only_translated) return(translated)
  s <- sd(x)
  translated / s
}
rescale(x = 1:4, only_translated = TRUE)
rescale(x = 1:4, only_translated = FALSE)

x <- 10
x

f <- function(x){
  
  print(x)
  
}
f(x = 5)
f(x)

f <- function(x){
  x <- 88
  print(x)
  
}

f(x = 5)
f(x)

x <- 10

f <- function(y) {
  print(y) # local
  print(x) # global
}

f(y = 5)

f <- function(y) {
  y <- 5
  print(y) # local
  print(x) # global
}

f()

x <- 1:5
x
(x <- 1:5)
invisible(x^2)

# Named Parameters and Default Parameters

rescale <- function(x , only_translated) {
  m <- mean(x)
  translated <- x-m
  if (only_translated) return(translated)
  s <- sd(x)
  translated / s
}

rescale(1:4 , TRUE)
rescale(x = 1:4 , TRUE)
rescale(1:4 , only_translated = TRUE)
rescale(x = 1:4, only_translated = TRUE)
rescale(x = 1:4, only_translated = FALSE)
rescale(1:4, o = TRUE)
rescale(x = 1:4)
rescale(only_translated = TRUE)


rescale <- function(x , only_translated = FALSE) {
  m <- mean(x)
  translated <- x-m
  if (only_translated) return(translated)
  s <- sd(x)
  translated / s
}
rescale(x = 1:4)
rescale(x = 1:4, only_translated = TRUE)


# The “Gobble Up Everything Else” Parameter: “...”

rescale <- function(x){ # 
  m <- mean(x)
  s <- sd(x)
  (x-m)/s
}

x <- c(NA,1:3)
x
rescale(x)

rescale <- function(x,...){ # 
  m <- mean(x,...)
  s <- sd(x,...)
  (x-m)/s
}
?mean
?sd

rescale(x, na.rm = TRUE)
#rescale(x, na.rm = F)


f <- function(x){
  x
}

g <- function(x,...){
  x
}

f(x = 1:4)
f(x = 1:4 , foo = "Car_T_Cell")
  
g(x = 1:4)
g(x = 1:4 , foo = "Car_T_Cell")


f <- function(...){
  list(...)
}

g <- function(x,y,...) {
  f(...)
}

g(x=1 , y=2, z=3 , w =4)


f <- function(w) {
  w
}

g <- function(x,y, ...){
  f(...)
}

g(x=1, y=2, z=3, w= 5)

f <- function(w,z) {
  w
}
g(x=1, y=2, z=3, w= 5)

# Lazy Evaluation

# Cons 1:

f <- function(a,b){
  a
}

f(a = 2 , b = stop("Error detected !"))

f(a = stop("Error detected !!"), b = 2)

# Cons 2 :

f <- function(x,y){
  if(x>0){
    y + 1
  } else {
    0
  }
}

f(x = -1 , y = stop("Error detected !!"))
f(x = 1 , y = stop("Error detected !!"))

# Cons 3 :

f <- function(a, b=a){
  a+b
}

f(a=2)

g <- function(a, b= 2*a, c = b+3){
  c
}

g(a = 4)



f <- function(a, b = a){
  a+b
}

a <- 10

f(a = 2, b = a)

a <- 1:5

f <- function(a, b=2*a){
  b
}

# Case 1 :

f(a = 2*a, b = 2*a)

# Case 2 :

f(a = 2*a)
# a EG ==> 1:5 ==> 2*(1:5) ==> 2,4,6,8,10
# b = 2*a ==> 2 * (2,4,6,8,10) ==> 4  8 12 16 20

f <- function(a){
  
  function(b){
    
    a+b
    
  }
}

f(1)
f(a = 2)(b = 2)

g <- f(2)
g
environment(g)
ls(environment(g))
get("a", environment(g))


g <- f(3)
g
environment(g)
ls(environment(g))
get("a", environment(g))



ff <- vector(mode = "list", length = 4 ) 
?vector
ff
str(ff)



f <- function(a){
  
  function(b){
    
    a+b
    
  }
}


for ( i in 1:4 ) { # 1:length(ff)
  
  ff[[i]] <- f(i)
  
  
}

# x <- 1:10
# x[5]
# t <- list(1,"TRUE", FALSE, 50, TRUE,NA)
# t[[6]]

ff[[1]]
environment(ff[[1]])
ls(environment(ff[[1]]))
get("a",environment(ff[[1]]))

ff[[1]](2)

f <- function(a){
  force(a)
  function(b){
    
    a+b
    
  }
}

for ( i in 1:4 ) { # 1:length(ff)
  
  ff[[i]] <- f(i)
  
  
}

ff[[1]](2)


results <- vector("numeric", 4)

for ( i in 1:4 ) { # 1:length(ff)
  
  results[i] <- ff[[i]](1)
  
  
}
results


# Functions Don’t Have Names

( function(x) x^2)(2)

# Vectorized Functions


x <- 1:5
y <- 6:10
x-y

2*x

x <- 1:6
y <- 1:3
x - y

# Not element wise behavior
f <- function(x){
  
  c(x,x+1) # glue
  
}

# b <- c(1,"TRUE","Nice")
# b

f(x = 3)
f(x = c(1,2,3))

# element wise behavior

g <- function(x){
  x+1
}
g(c(1,2,3)) # c(g(1), g(2), g(3))

log(1:3) - sqrt(1:3)

# Control structures "if statements"

compare <- function(x,y){
  if (x <y) {
    -1
  } else if (y<x) {
    1
  } else {
    0
  }
}

compare(x = 1,y = 3)
compare(x = 1:3,y = 1:3)

compare <- function(x,y) {
  ifelse(x<y , -1  ,ifelse( y<x , 1 , 0))
}

compare(x = 1:6,y = 1:3)

# IFELSE NO ALAWYS SUITABLE
# 1 = evalutes both branches
f <- function(x){
  ifelse(x>0, sqrt(x), log(x))
}

f(c(4,-1))
f(c(4,1))

# 2 = side effects twice

ifelse(c(TRUE,FALSE) ,print("yes") , print("no"))

# 3 = coercion

ifelse(c(TRUE,FALSE),1 ,"A" )
# TRUE == 1
# FALSE == 0
# TRUE == 0
# FALSE == 1
typeof(6)
typeof("6")

# 4 = complexity

compare <- function(x,y){
  if (x <y) {
    -1
  } else if (y<x) {
    1
  } else {
    0
  }
}

compare <- Vectorize(compare)

compare(x = 1:6 , y = 1:3)

scale_with <- function(x,y){
  x-mean(y)/sd(y)
}

scale_with(x = 1:6, y = 1:3)
?Vectorize
scale_with <- Vectorize(scale_with, vectorize.args = "x" )

scale_with(x = 1:6, y = 1:3)

# TREE STRUCTURE

make_node <- function( name ,right = NULL , left = NULL ){
  
  list(name = name, right = right, left = left)
  
}

# lt <- list(item_1 = 1,item_2 = TRUE, item_3 = 1.2, item_4 = "PC")
# lt$item_4

tree <- make_node(name = "root", right = make_node("D",make_node("E")),
                                 left = make_node("A", right = make_node("C"),left = make_node("B")))

# RECURSIVE THINKING
node_depth <- function(tree, name, depth = 0) {
  
  if (is.null(tree)) {return(NA)}    #empty
  if (tree$name == name ) { return(depth)}                       #found the node
   
  left <- node_depth(tree$left, name, depth + 1)                #search left
  if (!is.na(left)) {return(left)}
  
  right <- node_depth(tree$right, name, depth + 1)           #search right
  return(right)
}


# d <- c(1,3,NA) 
# length(d)
# g <- c(1,3,NULL) 
# length(g)

node_depth( tree, "root" )
node_depth( tree, "A" )

node_depth( tree, c("A","B","C","D" ))

node_depth <- Vectorize(node_depth, vectorize.args = "name",USE.NAMES = FALSE  )
node_depth( tree, c("A","B","C","D" ))
?Vectorize

# User-defined Infix Operators

# x OP y 
# OP(x,y)
# + - * / %% = == > < >= <= <-

`%x%` <- function(expr, num){
  
  replicate(num,expr)
  
}

#replicate( 5 , 3 )

3 %x% 5

cat("this is", "very" %x% 3, "much fun")

replicate( 5 , 3 )

sample(1:5 , 1)

replicate( 3 , sample(1:5,1))

sample(1:5,1) %x% 3

`%x%` <- function(expr, num){
  
  m <- match.call()
  replicate(num,  eval.parent(m$expr))
  
}

sample(1:5,1) %x% 5

# Replacement Functions  
# 1

x <- y <- 1:5 # x <- 1:5 ; y <- x
x
y

x[1] <- 6
x
y

# install.packages("lobstr")
library(lobstr)

rm(x)  ; rm(y)

# 2

x <- 1:100000000

obj_addr(x)
obj_size(x)

x[1] <- 6
x[1]

obj_addr(x)
obj_size(x)

typeof(x)
typeof(6)

# <- , two arguments, return value

x <- 1:5
x

x[1] <- 500
x

x[1] <- 600 # `[<-`(x,1,100)
x

names(x) <- letters[1:5] # x <- `names<-`(x,letters[1:4])
x

x <- 1:6
dim(x) <- c(2,3)
x

x <- 1:3 

class(x) <- "my class"
class(x)

f <- factor(c( "A","B","C"))
levels(f)

levels(f) <- c("Apple" , "Banana", "KIWI")
levels(f)

x <- 1:3

attr(x, "info") <- "My vector file"
x
attr(x, "date") <- "01-03-2026"
x
attr(x, "localization") <- "Morocco"
x

attributes(x)

attributes(x) <- list( info = "My vector file"  , date = "01-03-2026"  ,localization = "Morocco" )
x


# 


`myfunctionname<-` <- function(obj,value){
  
  ##
  value
  
}

make_node <- function( name ,right = NULL , left = NULL ){
  
  list(name = name, right = right, left = left)
  
}


tree <- make_node(name = "root", right = make_node("D",make_node("E")),
                  left = make_node("A", right = make_node("C"),left = make_node("B")))


# tree$left <- make_node("A")
# tree$right <-  make_node("B")

`left<-` <- function(obj ,value ){
  
  tree$left = value
  value
  
}

`right<-` <- function(obj ,value ){
  
  tree$right = value
  value
  
}

root <- make_node("root")
C <- make_node("C")
D <- make_node("D")
E <- make_node("E")
f <- make_node("F")


C$left <- E
C$right <- f

root$left <- C
root$right <- D
tree <- root

tree$left$name
tree$right$name
tree$left$left$name
tree$left$right$name

draw_tree <- function (tree) {
  
  if (is.null(tree$left) & is.null(tree$right)) {
    return(tree$name)
    
  } else {
    
    left <- draw_tree(tree$left)
    right <- draw_tree(tree$right)
    paste0( tree$name, "("  , left , ",", right, ")" )
    
  }
  
}
draw_tree(tree)
