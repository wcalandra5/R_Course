# Load data
library(utils)
ESPN_Proj <- read.csv("2019FantasyESPN.csv")

# Visualize performance
library(ggplot2)
ggplot(ESPN_Proj, aes(x=Proj,y=Actual)) + geom_point() + geom_smooth(method = lm, se=FALSE)

# Count NA values
sum(is.na(ESPN_Proj$Actual))

# Linear model on performance
Lm <- lm(data = ESPN_Proj, Actual ~ Proj)
summary(Lm)
# plot(Lm)

# Filter for > 10 pts
library(tidyverse)
ESPN_Proj %>%
  mutate(Over10 = ifelse(Actual > 10, 1, 0)) -> ESPN_Proj

ESPN_Proj10 <- filter(ESPN_Proj, Over10 == 1)
#ESPN_Proj2 <- subset(ESPN_Proj, Actual > 10)
#ESPN_Proj3 <- filter(ESPN_Proj, Actual > 10)

# Filter for WRs > 10 pts
ESPN_WRs <- filter(ESPN_Proj10, Pos == "WR")

# WRs model for performance
ggplot(ESPN_WRs, aes(x=Proj,y=Actual))+geom_point()+geom_smooth(method=lm,se=FALSE)

Lm <- lm(data = ESPN_WRs, Actual ~ Proj)
summary(Lm)
# Use the code below to check the residual plot
# plot(Lm, 1)

# Filter for Wk 16
ESPN_WRs_Wk16 <- filter(ESPN_WRs, Week == 16)

# Wk 16 model for performance
ggplot(ESPN_WRs_Wk16, aes(x=Proj,y=Actual))+geom_point()+geom_smooth(method=lm,se=FALSE)

Lm <- lm(data = ESPN_WRs_Wk16, Actual ~ Proj)
summary(Lm)

# Grab season WR data
Yearly_Data <- read.csv("2019FantasyYearlyData.csv")
Yearly_Data <- filter(Yearly_Data, Yearly_Data$Pos == "WR")

# Add weekly data
Yearly_Data %>% 
  mutate(RecYdsWk = ReceivingYds / G) %>% 
  mutate(TgtWk = Tgt / G) %>% 
  mutate(PPW = FantasyPoints / G) %>% 
  mutate(RecTDsWk = ReceivingTD / G) %>% 
  mutate(RecWk = Rec / G) %>% 
  mutate(FumWk = FumblesLost / G) -> Yearly_Data

## Receiving yards
# Linear model for receiving yards
ProjRecYds <- lm(data = Yearly_Data, RecYdsWk ~ TgtWk+RecTDsWk+RecWk)

# Get projection
Yearly_Data$ProjRecYdsWk <- predict(ProjRecYds)

# Analyze projection performance
ggplot(Yearly_Data, aes(x=ProjRecYdsWk,y=RecYdsWk))+geom_point()+geom_smooth(method=lm,se=FALSE)
summary(ProjRecYds)

# Multicollinearity check
library(car)
vif(ProjRecYds)

# Rerun projections without receptions
# Linear model for receiving yards
ProjRecYds <- lm(data = Yearly_Data, RecYdsWk ~ TgtWk+RecTDsWk)

# Get projection
Yearly_Data$ProjRecYdsWk <- predict(ProjRecYds)

# Analyze projection
ggplot(Yearly_Data, aes(x=ProjRecYdsWk,y=RecYdsWk))+geom_point()+geom_smooth(method=lm,se=FALSE)
summary(ProjRecYds)

# Multicollinearity check
vif(ProjRecYds)

## Receptions
# Linear model for receptions
ProjRec <- lm(data = Yearly_Data, RecWk ~ RecYdsWk+TgtWk)

# Get projection
Yearly_Data$ProjRecWk <- predict(ProjRec)

# Analyze projection
ggplot(Yearly_Data, aes(x=ProjRecWk,y=RecWk))+geom_point()+geom_smooth(method=lm,se=FALSE)
summary(ProjRec)

# Multicollinearity check
vif(ProjRec)

## Receiving touchdowns
# Linear model for receiving touchdowns
ProjRecTD <- lm(data = Yearly_Data, RecTDsWk ~ RecYdsWk)

# Get projection
Yearly_Data$ProjRecTDWk <- predict(ProjRecTD)

# Analyze projection
ggplot(Yearly_Data, aes(x=ProjRecTDWk,y=RecTDsWk))+geom_point()+geom_smooth(method=lm,se=FALSE)
summary(ProjRecTD)

# Generate final projection
Yearly_Data$Our_Proj_PPW <- Yearly_Data$ProjRecWk + 6*Yearly_Data$ProjRecTDWk + 0.1*Yearly_Data$ProjRecYdsWk - 2*Yearly_Data$FumWk

## Combine both dataframes - join on player
Merge <- merge(ESPN_WRs_Wk16, Yearly_Data, by = "Player")

## ESPN model performance
ggplot(Merge, aes(x=Proj,y=Actual))+geom_point()+geom_smooth(method=lm,se=FALSE)

Lm <- lm(data = Merge, Actual ~ Proj)
summary(Lm)

## Our model performance
ggplot(Merge, aes(x=Our_Proj_PPW,y=Actual))+geom_point()+geom_smooth(method=lm,se=FALSE)

Lm <- lm(data = Merge, Actual ~ Our_Proj_PPW)
summary(Lm)
