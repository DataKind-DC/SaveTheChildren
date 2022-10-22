## install.packages("remotes")
# remotes::install_gitlab("dickoa/rhdx")
# remotes::install_github("dickoa/rhdx")

library(rhdx)
library(tidyverse)

## Set to Production
set_rhdx_config(hdx_site = "prod")


## Search for datasets using keywords
list_of_ds <- search_datasets("fews Somalia", rows = 10)
list_of_ds

## Select a dataset from the list based on index
ds <- pluck(list_of_ds, 2)

## Show the "resources" contained within the dataset
get_resources(ds)


## Pipe above commands together
idp_nga_df <-
  search_datasets("displaced Nigeria", rows = 2) %>%
  pluck(1) %>%
  get_resource(1) %>% ## get the first resource
  read_resource(simplify_json = TRUE, download_folder = tempdir()) ## the file will be downloaded in a temporary directory


## Somalia Food Insecurity Datasets
search_datasets("subnational food security Somalia", rows = 10)

Somalia_Food_Insecurity <- search_datasets("subnational food security Somalia", rows = 10) %>%
  pluck(1) %>%
  get_resource(1) %>%
  read_resource()


Somalia_Food_Prices <- search_datasets("subnational food Somalia", rows = 10) %>%
  pluck(3) %>%
  get_resource(1) %>%
  read_resource()

Somalia_Food_Prices_FEWS_ADM1 <- search_datasets("subnational food Somalia", rows = 10) %>%
  pluck(10) %>%
  get_resource(1) %>%
  read_resource()

## Search for Population Statistics
search_datasets("Somalia population", rows = 10)
search_datasets("Somalia population", rows = 10) %>%
  pluck(3) %>%
  get_resources()

Somalia_Population_Statistics <- search_datasets("Somalia population", rows = 10) %>%
  pluck(3) %>%
  get_resource(1) %>%
  read_resource()


## Search for Poverty Statistics
search_datasets("Somalia population", rows = 10)
search_datasets("Somalia population", rows = 10) %>%
  pluck(3) %>%
  get_resources()

Somalia_Poverty_Statistics <- search_datasets("Somalia population", rows = 10) %>%
  pluck(3) %>%
  get_resource(1) %>%
  read_resource()

## Environmental Indicators
search_datasets("Somalia population", rows = 10)
Somalia_Envirenmental_Statistics <- search_datasets("Somalia population", rows = 10) %>%
  pluck(1) %>%
  get_resources(1) %>%
  read_resource()
