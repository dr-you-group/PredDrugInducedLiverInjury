drugConceptsPath <- system.file("settings", "DrugConceptsToCreate.csv", package="PredDrugInducedLiverInjury")

drugConceptsPath <- "~/dr-you-group/PredDrugInducedLiverInjury/inst/settings/DrugConceptsToCreate.csv"
drugConcepts <- read.csv(drugConceptsPath)

drugConcepts <- read.csv("./inst/settings/DrugConceptsToCreate.csv", stringsAsFactors = FALSE)

#SQL

S <- SqlRender::readSql("~/dr-you-group/PredDrugInducedLiverInjury/inst/sql/sql_server/MOAnormal_LFT_acetaminophen.sql")

for(i in seq(nrow(drugConcepts))){
  drugConceptId <- drugConcepts$concept_id[i]
  drugConceptName <- drugConcepts$concept_name[i]
  
  ##json
  #1125315 -> drugConceptId
  #acetaminophen -> drugConceptName
  #file name -> 
  
  ##sql
  #1125315 -> ConceptId
  #file name -> 
  
  SS <- gsub("drugConceptId", drugConceptId, S)
  filename <- paste0("MOAnormal_LFT_", drugConceptName, ".sql")
  writeLines(SS, filename)

}

#Json

J <- readLines("~/dr-you-group/PredDrugInducedLiverInjury/inst/cohorts/MOAnormal_LFT_acetaminophen.json")

for(i in seq(nrow(drugConcepts))){
  drugConceptId <- drugConcepts$concept_id[i]
  drugConceptName <- drugConcepts$concept_name[i]
  
  JJ <- gsub(1125315, drugConceptId, J)
  JJ <- gsub("acetaminophen", drugConceptName, JJ)
  filename <- paste0("MOAnormal_LFT_", drugConceptName, ".json")
  writeLines(JJ, filename)
  
}

i=1
