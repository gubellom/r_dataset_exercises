pacman::p_load(
  haven,     
  dplyr
)

df <- read_dta("C:/insertdirectory/ESS8e02_3.dta") 

##############################################################
### Generate dataset with aggregate data by country
##############################################################

### Average age by country
df_avg<-select(df, agea, cntry, anweight)

df_avg <- df_avg %>%
  group_by(cntry) %>%
  summarise(avg_age = weighted.mean(agea, anweight, na.rm=TRUE))
print(df_avg, n = Inf)

## Save the dataset 
write.csv2(df_avg, "C:\\insertdirectory\\df_avg.csv", row.names = FALSE)

#######################################
## Generate dataset by individual level.
#######################################

df_trust<-select(df, idno, ppltrst, cntry)

#Rescale social trust from [0,10] scale to [0,1] scale.
df_trust$ppltrst<- (df_trust$ppltrst)/10

write.csv2(df_trust, "C:\\insertdirectory\\df_trust.csv", row.names = FALSE)


#######################################
## Generate dataset for append
#######################################

df_append_austria<-df %>%
  filter(cntry == "AT")

write.csv2(df_append_austria, "C:\\insertdirectory\\df_append_austria.csv", row.names = FALSE)

