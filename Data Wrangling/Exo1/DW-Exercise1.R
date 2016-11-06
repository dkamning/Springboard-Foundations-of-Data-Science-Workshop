##Load libraries
library(dplyr)
library(dummies)

##0.Load dataset
my_dataset <- read.csv(file="./Data Wrangling/Exo1/refine_original.csv"
                  , head = TRUE, sep=",")
str(my_dataset)

##1. Clean up brand names
( my_dataset$company <-  tolower(my_dataset$company) ) 
(  my_dataset$company[grepl("ps$", my_dataset$company)] <- "philips" )
(  my_dataset$company[grepl("^ak", my_dataset$company)] <- "akzo" )
(  my_dataset$company[grepl("^van", my_dataset$company)] <- "van houten" )
(  my_dataset$company[grepl("ver$", my_dataset$company)] <- "unilever" )

##2. Separate product code and product number
my_dataset <- separate( data= my_dataset, col=Product.code...number
            , into = c("product_code", "product_number"), sep="-") 
str(my_dataset)

##3.Add product category
get_product_category <- function(productCode){
    productCode <- tolower(productCode)
    if( productCode == "p"){
      return("SmartPhone")
    }else if(productCode == "v"){
      return("TV")
    }
    else if(productCode == "x"){
      return("Laptop")
    }else if(productCode == "q"){
      return("Tablet")
    }
}

my_dataset <- my_dataset %>% 
  mutate( product_category = sapply(product_code, get_product_category)  )
str(my_dataset)


##4. Geocode addresses
my_dataset <- my_dataset %>% 
  mutate( full_address = paste(address ,city,country, sep= ", " )  )  
str(my_dataset)

##5. Create dummy variables for company and category columns
#Keeping copies of original columns for verification
my_dataset <- data.frame(append(my_dataset
                            ,list(product = my_dataset$product_category )
                            ,after=match("product_category", names(my_dataset))))
my_dataset <- data.frame(append(my_dataset
                  ,list(brand = my_dataset$company )
                  ,after=0))

my_dataset <- dummy.data.frame( names=c("company","product")
                                , data = my_dataset, sep="_", drop=TRUE
                                , fun=as.integer, verbose=FALSE) 
str( my_dataset)

##Output
write.csv(my_dataset, file = "./Data Wrangling//Exo1/refine_clean.csv"
          , row.names = FALSE, append = FALSE)

