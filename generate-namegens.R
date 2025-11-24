# Load necessary library
library(dplyr)

# Define name generators
custom_labels <- data.frame(
  question = 1:12,
  label_en = c(
    "Question 1: When you are in need of some help, from whom could you borrow about K120?",
    "Question 2: Suppose someone is in need of help, to whom would you lend about K120?",
    "Question 3: Which households normally share their food with you?",
    "Question 4: With which households do you normally share your food with?",
    "Question 5: Who goes most often to work in the garden with the women of the househould?",
    "Question 6: Who goes most often to work in the garden with the men of the househould?",
    "Question 7: With whom do the women of the household share stories most often?",
    "Question 8: With whom do men of the household share stories most often?",
    "Question 9: Who are the government and NGO employees whom you know well?",
    "Question 10: When you bring your produce to sell/trade, who are the merchants/traders you work with?",
    "Question 11: Who goes most often fishing or picking seashells with the women in the household?",
    "Question 12: Who goes most often fishing with the men in the household?"
  ),
  label_tp = c(
    "Question 1: Sapos yu laikim sampela halivim, yu go askim husat bilong borowim klostu K120?",
    "Question 2: Sapos sampela lain i lakim halivim klostu K120, bai yu givim husat na em bai bekim lo taim i kam bihain?",
    "Question 3: Wanem femili i save sherim kaikai wantaim yu?",
    "Question 4: Yu save sherim kaikai bilong yu wantaim husat femili?",
    "Question 5: Ol meri insait lo haus bilong yu i save go lo gaden wantaim husat poromeri o poroman em yet planti taim steret?",
    "Question 6: Ol man insait lo haus bilong yu i save go lo gaden wantaim husat poromeri o poroman em yet planti taim steret?",
    "Question 7: Ol meri insait lo haus bilong yu i save stori wantaim husat poromeri o poroman em yet planti taim steret?",
    "Question 8: Ol man insait lo haus bilong yu i save stori wantaim husat poromeri o poroman em yet planti taim steret?",
    "Question 9: Yupela i save gut husat ol memba bilong gavaman o ol memba bilong sampela association husat i halivim ol narapela, olsem Red Cross o Save the Children?",
    "Question 10: Taim yupela i bringim kaikai bilong yupela lo maket, bai yupela go yupela yet o bai yupela i askim narapela man o meri long salim?",
    "Question 11: Ol meri insait lo haus bilong yu i save go hukim pis o pikim sel wantaim husat ol poromeri o ol poroman planti taim steret ?",
    "Question 12: Ol man insait lo haus bilong yu i save go hukim pis wantaim husat ol poromeri o ol poroman planti taim steret?"
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
        label..Tok.Pidgin..tp. = ifelse(
          type != "end_repeat" & name %in% c(paste0("namegen", suffix), paste0("alters", suffix)),
          custom_labels$label_tp[custom_labels$question == suffix],
          label..Tok.Pidgin..tp.
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
template$label..Tok.Pidgin..tp. <- gsub("2", "REPLACE", template$label..Tok.Pidgin..tp.)
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
    new_data$label..Tok.Pidgin..tp. <- gsub("REPLACE", as.character(suffix), new_data$label..Tok.Pidgin..tp.)
    new_data$relevant <- gsub("REPLACE", as.character(suffix), new_data$relevant)
    new_data$calculation <- gsub("REPLACE", as.character(suffix), new_data$calculation)
    new_data$repeat_count <- gsub("REPLACE", as.character(suffix), template$repeat_count)

    ## Add in name generator question text
    new_data <- new_data %>%
      mutate(
        label..English..en. = ifelse(name == paste0('namegen_details', suffix), custom_labels$label_en[custom_labels$question == suffix], label..English..en.),
        label..Tok.Pidgin..tp. = ifelse(name == paste0('namegen_details', suffix), custom_labels$label_tp[custom_labels$question == suffix], label..Tok.Pidgin..tp.)
      )

    ## Add all previously mentioned alters
    names_to_add <- paste0("${new_alters", seq(1, suffix - 1), "}", collapse = " ")
    new_data <- new_data %>%
      mutate(
        label..English..en. = ifelse(name == paste0('namesfromprev', suffix), names_to_add, label..English..en.),
        label..Tok.Pidgin..tp. = ifelse(name == paste0('namesfromprev', suffix), names_to_add, label..Tok.Pidgin..tp.)
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

# Other bits -------------------------------------------------------------------
initial_section <-  read.csv("template-initialpart.csv", stringsAsFactors = FALSE, na.strings = "") %>% tibble
part_compensation <-  read.csv("template-partcompensation.csv", stringsAsFactors = FALSE, na.strings = "") %>% tibble

# Generate new data frame for the suffixes

#generate_name_interpreter(template, n_quest)  %>% tibble %>% print(n = 50)

result <- bind_rows(
  initial_section,
  generate_first_part(template_namegens, n_quest),
  generate_name_interpreter(template, n_quest),
  # generate_dm(template_dm, 8),
  # ladderetal,
  part_compensation
)

# Write the result to a new CSV file
write.csv(result, "generated_namegens.csv", row.names = FALSE, na = "")
