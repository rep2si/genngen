# Load necessary library
library(dplyr)

# Define name generators
custom_labels <- data.frame(
  question = 1:20,
  label_en = c(
    "Question 1: If you had an unexpected emergency expense, for example for a treatment at the hospital, who could lend you NPR 2,000 or more?", 
    "Question 2: Who would come to ask you for a loan of NPR 2,000 or more, if they had an unexpected emergency expense, for example for a treatement at the hospital?", 
    "Question 3: If you need some basic essentials---for example oil, masala, uncooked rice or lentils---who could you ask and obtain from?", 
    "Question 4: If they need some basic essentials---for example oil, masala, uncooked rice or lentils---who could ask you and obtain?", 
    "Question 5: For [you and the other women / the women] in your household, who helps you with tasks? For example, cooking, cleaning, housework. Or working in khet-baari, for example by doing parma?", 
    "Question 6: For [you and the other men / the men] in your household, who helps you with tasks? For example, doing work around the house? Or working in khet-baari, for example by doing parma?", 
    "Question 7: For [you and the other women / the women] in your household, who do you enjoy having casual conversations with?", 
    "Question 8: For [you and the other men / the men] in your household, who do you enjoy having casual conversations with?", 
    "Question 9: Who do you know well who currently works for an NGO, the government (sarkari karmachari), the police, or who has a high position in a political party---and who could help you?", 
    "Question 10: Who are the people in Chautara or Kathmandu, abroad, or elsewhere, who get things done for you?", 
    "Question 11: If you urgently needed to borrow NPR 400, who could you ask and obtain this from? For example, if you do not have it in your pocket when you need it.", 
    "Question 12: If they urgently needed to borrow NPR 400, who could ask you for this and obtain it from you? For example, if they do not have it in your pocket when they need it.", 
    "Qeustion 13: If you wanted to discuss important and confidential matters, who would you talk to?", 
    "Question 14: Who do you call to do parma (without money), and they will come?", 
    "Question 15: Who do you call to do mela (work for money), and they will come?",
    "Question 16: Who calls you for mela (work for money), and you will go?",
    "Question 17: If you or a member of your family wants paid work, whether in the village or outside (in Chautara, Kathmandu or abroad or anywhere else), who can you contact and obtain work?",
    "Question 18: In both parts of Gidane, who do you you see as influential, when they speak others listen?",
    "Question 19: In both parts of Gidane, who do you see as generous?",
    #"Question 20: In both parts of Gidane, who do you you see as fair?",
    "Question 20: In both parts of Gidane, who do you you see as devout?"
  ),
  label_ne = c(
    "Question 1: यदि तपाईंलाई एक्कासी आपतकालिन खर्च गर्नुपर्ने भयो भने, जस्तै अस्पतालमा उपचारको लागि, तपाईंलाई रु.२००० वा त्यो भन्दा बढी ऋण कस-कसले दिन्छ?", 
    "Question 2: यदि कसैलाई एक्कासी आपतकालिन खर्च गर्न, जस्तै अस्पतालमा उपचारका लागि, रु.२००० वा त्यो भन्दा बढी चाहियो भने, त्यस्ता को-को छन् जो तपाईंसँग माग्न आएको खण्डमा तपाईंले दिनु हुन्छ?", 
    "Question 3: यदि तपाईंलाई नभइनहुने सामान जस्तै राशनपानी, तेल, मसला, चाहियो भने, यी सामान तपाईं  को-कोसँग मागरे पाउनुहुन्छ जस्तै ऐँचोपैँचो गर्दा को-कोसँग मागेर पाउनुहुन्छ?",
    "Question 4: यदि कसैलाई नभइनहुने सामान जस्तै राशनपानी, तेल, मसला चाहियो भने, त्यस्ता को-को छन् जो तपाईंसँग माग्न आएको खण्डमा तपाईंले दिनु हुन्छ, जस्तै ऐँचोपैँचो गर्दा को-को तपाईंसँग मागेर पाउँछन्?",
    "Question 5: [तपाईं र] तपाईंको घरका [अन्य] महिलालाई जुनपनि कामहरुमा, जस्तै खाना पकाउने, सरसफाई गर्ने, बच्चा हेर्ने, मकै छोडाउने, घाँस काट्ने, वस्तु खुवाउने, कस-कसले सहयोग गर्छ?", 
    "Question 6: [तपाईं र] तपाईंको घरका [अन्य] पुरुषलाई जुनपनि कामहरुमा, जस्तै मर्मत गर्ने, घरको काम, खेतमा धानको हेरचाह गर्ने, बाँदर-बँदेल र अन्य जनावारहरुलाई लखेट्न, कस-कसले सहयोग गर्छ?", 
    "Question 7: [तपाईं र] तपाईंको घरका [अन्य] महिलाहरु गफ गर्नुपर्‍यो भने को-कोसँग गफ गर्नुहुन्छ?", 
    "Question 8: [तपाईं र] तपाईंको घरका [अन्य] पुरुषहरु गफ गर्नुपर्‍यो भने को-कोसँग गफ गर्नुहुन्छ?", 
    "Question 9: तपाईंले एनजिओ, सरकार(सरकारी कर्मचारी), पुलिस वा कुनै पनि राजनितिक पार्टीको पदमा भएको कस-कसलाई चिन्नुहुन्छ जसले परेको बेला तपाईंलाई सहयोग गर्न सक्छ?", 
    "Question 10: चौतारा, काठमाडौं, विदेश वा अरुनै कुनै ठाउँमा तपाईंको लागि केहि काम गरिदिने मान्छेहरु को-को छन्?", 
    "Question 11: तत्काल जरुरी परेको अवस्थामा, जस्तै तपाईंलाई चाहियो तर गोजिमा भएन, भने तपाईं रु.४०० ऋण  को-को बाट पाउन सक्नुहुन्छ?", 
    "Question 12: यदि कसैलाई तत्काल जरुरी परेको अवस्थामा, जस्तै चाहियो तर गोजिमा भएन, भने त्यस्ता कोको छन् जसले तपाईंसँग रु.४०० ऋण मागेको खण्डमा तपाईंले दिनुहुन्छ?", 
    "Qeustion 13: महत्वपूर्ण र गोप्य छलफल गर्नुपर्दा तपाईं को-कोसँग कुरा गर्नुहुन्छ?", 
    "Question 14: पर्ममा(पैसा बिना) कस-कसलाई बोलाउनुभएको खण्डमा तपाईंकोमा काम गर्न आउँछन्?", 
    "Question 15: मेलामा(पैसा दिएर काम गर्न) कस-कसलाई बोलाउनुभएको खण्डमा तपाईंकोमा काम गर्न आउँछन्?",
    "Question 16: तपाईंलाई मेलामा (पैसा दिएर काम गर्न) कस-कसले बोलाएको खण्डमा काम गर्न जानुहुन्छ?",
    "Question 17: यदि तपाईंलाई वा तपाईंको परिवारमा कसैलाई कमाउन काम चाहिएको छ भने, गाउँमै भए पनि वा गाउँ बाहिर चौतारा, काठमाडौं, विदेश वा अरुनै कुनै ठाउँ  गएर भए पनि,को-कोसँग सम्पर्क गरेर तपाईंले काम पाउन सक्नुहुन्छ?",
    "Question 18: वल्लो र पल्लो गिदानेमा प्रभावशाली, जसले भनेको सबैले सुन्छन्, त्यस्तो मान्छेहरु को-को हुनुहुन्छ?",
    "Question 19: वल्लो र पल्लो गिदानेमा को-को उदार हुनुहुन्छ?",
    #"Question 20: वल्लो र पल्लो गिदानेमा को-को निष्पक्ष हुनुहुन्छ?",
    "Question 20: वल्लो र पल्लो गिदानेमा जुनसुकै धर्म भएपनि (चाहे हिन्दु होस्, इसाइ होस् वा सच्चाई होस्) भक्ति, साधना र धर्मकर्म धेरै गर्ने मान्छेहरु को-को हुनुहुन्छ?"
  ),
  stringsAsFactors = FALSE
)

n_quest <- nrow(custom_labels)

# First part: namegens ---------------------------------------------------------

# Read the CSV file
template_namegens <- read.csv("template-namegens.csv", stringsAsFactors = FALSE, na.strings = "") %>% tibble

# Changes to first template
template_namegens$name <- gsub("1", "REPLACE", template_namegens$name)

generate_first_part <- function(data, n_ngens) {
  all_rows <- list()
  template_columns <- colnames(data) # Store column names of the template
  # construct rows for each question
  for (suffix in seq_len(n_ngens)) {
    new_data <- data
    new_data$name <- gsub("REPLACE", as.character(suffix), new_data$name)
    new_data <- new_data %>%
      mutate(
        label..English..en. = ifelse(
          type != "end_repeat" & name %in% c(paste0("namegen", suffix), paste0("alters", suffix)),
          custom_labels$label_en[custom_labels$question == suffix],
          label..English..en.
        ),
        label..Nepali..ne. = ifelse(
          type != "end_repeat" & name %in% c(paste0("namegen", suffix), paste0("alters", suffix)),
          custom_labels$label_ne[custom_labels$question == suffix],
          label..Nepali..ne.
        ),
      )
    all_rows <- bind_rows(all_rows, new_data)
  }
  return(all_rows) 
}

# Second part: name 'interpreters' ---------------------------------------------
template <- read.csv("template.csv", stringsAsFactors = FALSE, na.strings = "") %>% tibble

# Changes to second template
template$name <- gsub("2", "REPLACE", template$name)
template$label..English..en. <- gsub("2", "REPLACE", template$label..English..en.)
template$label..Nepali..ne. <- gsub("2", "REPLACE", template$label..Nepali..ne.)
template$relevant <- gsub("2", "REPLACE", template$relevant)
# template$calculation <- gsub("prev_named_alters1", "REPLACEMINUS", template$calculation)
template$calculation <- gsub("2", "REPLACE", template$calculation)
template$default <- gsub("2", "REPLACE", template$default) #not sure this part of template actually needed
template$repeat_count <- gsub("2", "REPLACE", template$repeat_count) #not sure this part of template actually needed
# template$calculation <- gsub("name2", "nameREPLACE", template$calculation)
# template$calculation <- gsub("contacts2", "contactsREPLACE", template$calculation)

# Define the range of suffixes to generate (e.g., 2:15)

# Create a function to replicate rows for each suffix
generate_name_interpreter <- function(data, n) {
  all_rows <- list()
  template_columns <- colnames(data) # Store column names of the template
  
  for (suffix in seq_len(n)) {
    # Duplicate and update rows for this suffix
    new_data <- data
    new_data$name <- gsub("REPLACE", as.character(suffix), new_data$name)
    new_data$label..English..en. <- gsub("REPLACE", as.character(suffix), new_data$label..English..en.)
    new_data$label..Nepali..ne. <- gsub("REPLACE", as.character(suffix), new_data$label..Nepali..ne.)
    new_data$relevant <- gsub("REPLACE", as.character(suffix), new_data$relevant)
    new_data$calculation <- gsub("REPLACE", as.character(suffix), new_data$calculation)
    new_data$repeat_count <- gsub("REPLACE", as.character(suffix), template$repeat_count)

    ## Add in name generator question text
    new_data <- new_data %>%
      mutate(
        label..English..en. = ifelse(name == paste0('namegen_details', suffix), custom_labels$label_en[custom_labels$question == suffix], label..English..en.),
        label..Nepali..ne. = ifelse(name == paste0('namegen_details', suffix), custom_labels$label_ne[custom_labels$question == suffix], label..Nepali..ne.)
      )

    ## Add all previously mentioned alters
    names_to_add <- paste0("${new_alters", seq(1, suffix - 1), "}", collapse = " ")
    new_data <- new_data %>%
      mutate(
        label..English..en. = ifelse(name == paste0('namesfromprev', suffix), names_to_add, label..English..en.),
        label..Nepali..ne. = ifelse(name == paste0('namesfromprev', suffix), names_to_add, label..Nepali..ne.)
      )

   # Remove unnecessary rows for first question
    if (suffix == 1) {
      new_data <- new_data  %>% 
        filter(!(name %in% c("namedbefore1", "namedbefore1yes", "namesfromprev1",
                             "wherenamed1", "namedbefore1no"))) %>%
        filter(!(type %in% c("end_group")))
    }

  all_rows <- bind_rows(all_rows, new_data)
  }
  return(all_rows)
}

  #   # Add the growing displaynamesfromques... for preceding questions in the right place
  #   displaynames_row_position <- which(new_data$name == "displaynamesfromques1")
  #   displaynames_row <- new_data[which(new_data$name == "displaynamesfromques1"),]
  #   top <- new_data[1:displaynames_row_position - 1,]
  #   bottom <- new_data[displaynames_row_position + 1:nrow(new_data),]
  #   bottom <- subset(bottom, is.na(bottom$type) == FALSE ) ## NA rows being added for reasons I don't know
    
  #   if(suffix == 2) {
  #     note_rows = displaynames_row
  #   } else {
      
  #     note_rows <- do.call(rbind, rep(list(displaynames_row), suffix - 1))
      
  #     for (case in 2:suffix - 1) {
  #       note_rows$name[case] <- paste0("displaynamesfromques", case)
  #       note_rows$label..English..en.[case] <- paste0("People named in Question ", case, ": ${allcontacts", case, "}")
  #       note_rows$label..Nepali..ne.[case] <- paste0("People named in Question ", case, ": ${allcontacts", case, "}")
  #     }
      
  #     note_rows[1,] <- displaynames_row
  #   }
    
  #   all_three <- list(top, note_rows, bottom)
    
   #   # Combine all note rows for this suffix
   #   all_rows[[length(all_rows) + 1]] <- do.call(rbind, all_three)
#     }
  
#   # Combine all rows
#   do.call(rbind, all_rows)
# }

# Decision makers --------------------------------------------------------------

custom_dm_labels <- data.frame(
  question = 1:8,
  label_en = c(
    "What to cook on a daily basis.", 
    "Whether to buy an expensive item such as a TV, or a buffalo.", 
    "How many children you have.", 
    "What to do if you fall sick.", 
    "Whether to buy land or property.", 
    "How much money to spend on a social function such as marriage.", 
    "What to do if a child falls sick.", 
    "To whom your children should marry."
  ),
  label_ne = c(
    "दैनिक के पकाउने?", 
    "टीभी वा फ्रिज जस्तो महँगो सामान किन्नुपर्छ कि पर्दैन भनेर?", 
    "तपाईंको कतिवटा बच्चाहरु हुनुपर्छ?",
    "बिरामी पर्नुभयो भने के गर्ने?",
    "जग्गा वा सम्पत्ति किन्ने कि नकिन्ने?", 
    "विवाहजस्ता सामाजिक कार्यहरुमा कति पैसा खर्च गर्ने?", 
    "बच्चा बिरामी परे के गर्ने?", 
    "तपाईंको बच्चाले कससँग विवाह गर्नुपर्छ भन्ने निर्णय कसले गर्छ?" 
  ),
  stringsAsFactors = FALSE
)

template_dm <- read.csv("template-decisionmakers.csv", stringsAsFactors = FALSE, na.strings = "") %>% tibble

# To replace
template_dm$name <- gsub("1", "REPLACE", template_dm$name)
template_dm$label..English..en. <- gsub("1", "REPLACE", template_dm$label..English..en.)
template_dm$label..Nepali..ne. <- gsub("1", "REPLACE", template_dm$label..Nepali..ne.)
template_dm$relevant <- gsub("decision_makers1", "decision_makersREPLACE", template_dm$relevant)
template_dm$relevant <- gsub("decision_makers_n1", "decision_makers_nREPLACE", template_dm$relevant)
template_dm$calculation <- gsub("decision_makers1", "decision_makersREPLACE", template_dm$calculation)
template_dm$repeat_count <- gsub("1", "REPLACE", template_dm$repeat_count)
template_dm$choice_filter <- gsub("1", "REPLACE", template_dm$calculation)

generate_dm <- function(data, n_dm) {
  all_rows <- list()
  template_columns <- colnames(data) # Store column names of the template
  # construct rows for each question
  for (suffix in seq_len(n_dm)) {
    new_data <- data
    new_data$name <- gsub("REPLACE", as.character(suffix), new_data$name)
    new_data$label..English..en. <- gsub("REPLACE", as.character(suffix), new_data$label..English..en.)
    new_data$label..Nepali..ne. <- gsub("REPLACE", as.character(suffix), new_data$label..Nepali..ne.)
    new_data$relevant <- gsub("REPLACE", as.character(suffix), new_data$relevant)
    new_data$calculation <- gsub("REPLACE", as.character(suffix), new_data$calculation)
    new_data$repeat_count <- gsub("REPLACE", as.character(suffix), new_data$repeat_count)
    new_data$choice_filter <- gsub("REPLACE", as.character(suffix), new_data$choice_filter)

    new_data <- new_data %>%
      mutate(
        label..English..en. = ifelse(name == paste0('decision_makers', suffix), custom_dm_labels$label_en[custom_dm_labels$question == suffix], label..English..en.),
        label..Nepali..ne. = ifelse(name == paste0('decision_makers', suffix), custom_dm_labels$label_ne[custom_dm_labels$question == suffix], label..Nepali..ne.)
      )
    
    all_rows <- bind_rows(all_rows, new_data)
  }
  return(all_rows) 
}

# MacLadder and friends --------------------------------------------------------

ladderetal <- read.csv("template-ladder.csv", stringsAsFactors = FALSE, na.strings = "") %>% tibble

# Other bits -------------------------------------------------------------------
initial_section <-  read.csv("template-initialpart.csv", stringsAsFactors = FALSE, na.strings = "") %>% tibble
part_compensation <-  read.csv("template-partcompensation.csv", stringsAsFactors = FALSE, na.strings = "") %>% tibble

# Generate new data frame for the suffixes

#generate_name_interpreter(template, n_quest)  %>% tibble %>% print(n = 50)

result <- bind_rows(
  initial_section,
  generate_first_part(template_namegens, n_quest),
  generate_name_interpreter(template, n_quest),
  generate_dm(template_dm, 8),
  ladderetal,
  part_compensation
)

# Write the result to a new CSV file
write.csv(result, "generated_namegens.csv", row.names = FALSE, na = "")
