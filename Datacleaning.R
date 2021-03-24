setwd("~/ML Mini Project/MLPROJECT")
Data1 <-  read.csv(file = "Vehiclecoupondata.csv",na.strings=c("","NA")) # Replacing the empty strings in the file with NA
Data1$age <- as.integer(Data1$age)
Data1$temperature <- as.character(Data1$temperature)
Data1$toCoupon_GEQ5min <- as.character(Data1$toCoupon_GEQ5min)
Data1$toCoupon_GEQ15min <- as.character(Data1$toCoupon_GEQ15min)
Data1$toCoupon_GEQ25min <- as.character(Data1$toCoupon_GEQ25min)
Data1$direction_same <- as.character(Data1$direction_same)
Data1$direction_opp <- as.character(Data1$direction_opp )
Data1$Y <- as.character(Data1$Y)
Data1$childrennumber <- as.character(Data1$childrennumber)

# categorizing the age
Dataformat <- function(Data){
    Data1 <- 
    for (i in 1:length(Data)){
      if (Data[i] %in% c(0:20)){
        Data[i] <-  "below 21"
      }
      else if (Data[i] %in% c(21,22,23,24,25)){
        Data[i] <-  "21-25"
      }
      else if (Data[i] %in% c(26,27,28,29,30)){
        Data[i] <-  "26-30"
      }
      else if (Data[i] %in% c(31,32,33,34,35)){
        Data[i] <-  "31-35"
      }
      else if (Data[i] %in% c(36,37,38,39,40)){
        Data[i] <-  "36-40"
      }
      else if (Data[i] %in% c(41,42,43,44,45)){
        Data[i] <- "41-45"
      }
      else if(Data[i] %in% c(46,47,48,49,50)){
        Data[i] <-  "46-50"
      }
      else if(Data[i] %in% c(50:100)){
        Data[i] <-  "50 plus"
      }
      else if (Data[i]  %in% c(NA)){
        Data[i] <-  NA
      }
    }
    Data
  }
Data1$age <- Dataformat(Data1$age)
Data1 <-  data.frame(Data1)
Data1 <- na.omit(Data1)
str(Data1)
# Categorizing the data according to the coupon
Data_coffee <- Data1[Data1$coupon == "Coffee House",]
Data_bar <- Data1[Data1$coupon == "Bar",]
Data_restaurant_lessexpensive <- Data1[Data1$coupon == "Restaurant(<20)",]
Data_restaurant_expensive <- Data1[Data1$coupon == "Restaurant(20-50)",]
Data_takeaway <- Data1[Data1$coupon == "Carry out & Take away",] 

# Deleting the coupon column for the respective data
Data_coffee$coupon <- NULL
Data_bar$coupon <- NULL
Data_restaurant_lessexpensive$coupon <- NULL
Data_restaurant_expensive$coupon <-  NULL
Data_takeaway$coupon <- NULL


# creating CSV file for the dataset
write.csv(Data_coffee,file = "Data_coffee.csv",row.names=F)
write.csv(Data_bar, file = "Data_bar.csv",row.names=F)
write.csv(Data_restaurant_lessexpensive, file = "Data_restaurant_lessexpensive.csv",row.names=F)
write.csv(Data_restaurant_expensive , file = "Data_restaurant_expensive.csv",row.names=F)
write.csv(Data_takeaway , file = "Data_takeaway.csv",row.names=F)
  


