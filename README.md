# genngen
## Generate name generator survey form for Kobo

This code assumes you already have a number of template CSVs for starting parts of this survey: 

- **template-initialpart.csv**: a preamble of the starting bit that Kobo needs and that opens the survey (e.g., records participant ID and takes a photo of a physical signed informed consent form)
- **template-namegens.csv**: the basic structure for name generators. 
- **template.csv**: the main bit -- all of the name interpreters to be associated with each name generator. It is possible that you will want to change some of the questions here (e.g., currently asks about residency in community - that branching may not be relevant elsewhere)
- templates for extra questions we're asking... 
    - **template-decisionmakers.csv**: for the household decision-making questions
    - **template-ladder.csv**: for the self-efficacy, trust, MacArthur ladder, etc. questions we're asking
- **template-partcompensation.csv**: the final bit covering compensation, wrap-up. Here, this assumes that there is a physical receipt for payment being signed and then photographed within Kobo.

The Kobo output also assumes that there is an associated **indiv.csv** file which stores relevant census information (currently with variables: "name", "IndivID", "firstname", "jati", "age", "gender", "location", "education", "occupation", "resident", "fathersname", "mothersname"), and an **individual.csv** (with variables: "list_name", "name", "label") that can be called up to show the name for an associated ID (entries have 'individual' for the "list_name" variable, the "name" aka ID which serves as a unique key to link to the indiv.csv file, and a label that shows name and other helpful information to quickly scan concatenated together). 

Note that for additional languages (e.g., Hindi) you'll want either to replace all columns and references to Nepali, or add in new columns/references to the new language. 

For the social support name generators and the household decision-making questions, you also need to define at the outset the set of prompts (in whatever languages are needed). Having set up a first question via the template, this then generates equivalent bits for all subsequent prompts. 

This will then output a CSV **generated_namegens.csv** which _should_ be workable for Kobo!

Note that this is intended for use with Kobo Collect -- it may be exceedingly slow using the webpage-based version on a tablet. 