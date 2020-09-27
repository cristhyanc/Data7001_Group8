library(pdftools)
library(tibble) ##
library(tidyverse)
library(tm)
library(qdapDictionaries)
library(rlist)

ingest_spending_data <- function() {
        pdf_file <- "https://www.dsdmip.qld.gov.au/resources/plan/capital-program-sept2020.pdf"
        #txt <- pdf_text(pdf_file)
        SIP_pdf <- suppressMessages(pdf_data(pdf_file))
        
        num_pages <- length(lengths(SIP_pdf))
        pdf_df <- data.frame()
        df <- data.frame()
        for (page in 1:num_pages){
                SIP_pdf_page <- SIP_pdf[[page]]
                line_ys <- unique(SIP_pdf_page$y)
                words <- vector()
                first_number <- vector()
                for (i in 1:length(line_ys)) {
                        line_vect <- as.vector(SIP_pdf_page$text[SIP_pdf_page$y==line_ys[i]])
                        position_of_last_word = -1
                        position_of_first_number = -1
                        for (j in 1:length(line_vect)) {
                                word = line_vect[j]
                                
                                if (length(word) > 0) {
                                        if (!is.na(word)) {
                                                if (sum(substr(word, 1, 1)==c(letters, LETTERS)) > 0) {
                                                        position_of_last_word = j
                                                } else if ( !is.na(suppressWarnings(as.numeric(word))) & (position_of_first_number == -1) ) {
                                                        position_of_first_number = j
                                                }
                                        }
                                }
                        }
                        if (position_of_last_word != -1) {
                                words[i] = paste(line_vect[1:position_of_last_word], collapse=" ")
                        } else {
                                words[i] = ""
                        }
                        if (position_of_first_number != -1) {
                                first_number[i] <- line_vect[position_of_first_number]
                        } else {
                                first_number[i]  = NA
                        }
                        
                }
                
                if (length(words) == 1 & words[1]=="") {
                        words <- vector()
                        first_number <- vector()
                }
                this_df <- data.frame(page = rep(page, i),y=line_ys, words, first_number)
                pdf_df <- rbind(pdf_df, this_df)
        }
        return(pdf_df)
}



ingest_spending_data2 <- function() {
        pdf_file <- "https://www.dsdmip.qld.gov.au/resources/plan/capital-program-sept2020.pdf"
        #txt <- pdf_text(pdf_file)
        SIP_pdf <- suppressMessages(pdf_data(pdf_file))
        
        num_pages <- length(lengths(SIP_pdf))
        this_words_df <- data.frame()
        this_first_number_df <- data.frame()
        words_df <- data.frame()
        first_number_df <- data.frame()
        for (page in 1:num_pages){
                SIP_pdf_page <- SIP_pdf[[page]]
                line_ys <- unique(SIP_pdf_page$y)
                words <- vector()
                first_number <- vector()
                for (i in 1:length(line_ys)) {
                        line_vect <- as.vector(SIP_pdf_page$text[SIP_pdf_page$y==line_ys[i]])
                        position_of_last_word = -1
                        position_of_first_number = -1
                        for (j in 1:length(line_vect)) {
                                word = line_vect[j]
                                if (length(word) > 0) {
                                        if (!is.na(word)) {
                                                if (sum(substr(word, 1, 1)==c(letters, LETTERS)) > 0) {
                                                        position_of_last_word = j
                                                } else if ( !is.na(suppressWarnings(as.numeric(word))) & (position_of_first_number == -1) ) {
                                                        position_of_first_number = j
                                                }
                                        }
                                }
                        }
                        if (position_of_last_word != -1) {
                                words[i] = paste(line_vect[1:position_of_last_word], collapse=" ")
                        } else {
                                words[i] = ""
                        }
                        if (position_of_first_number != -1) {
                                first_number[i] <- line_vect[position_of_first_number]
                        } else {
                                first_number[i]  = NA
                        }
                        
                }
                
                if (length(words) == 1 & words[1]=="") {
                        words <- vector()
                        first_number <- vector()
                }
                this_words_df <- data.frame(page = rep(page, i),y=line_ys, words)
                this_first_number_df <- data.frame(page = rep(page, i),y=line_ys, first_number)
                words_df <- rbind(words_df, this_words_df)
                first_number_df <- rbind(first_number_df, this_first_number_df)
        }
        return(list(words_df,first_number_df))
}



group_multiline_items <- function(words_df) {
        groups <- rep(NA, nrow(words_df))
        # print(groups)
        for (i in 1:nrow(words_df)) {
                # print(paste("looking at i=", as.character(i), sep=""))
                if (is.na(groups[i])) {
                        groups[i] <- i
                }
                # print(paste("groups[i] = ", as.character(groups[i]), sep=""))
                this_group <- i
                this_y <- words_df[i, ]$y
                this_page <- words_df[i, ]$page
                for (offset in c(-11, -10, -9, 9, 10, 11)) {
                        # this_group <- c(this_group, as.numeric(row.names(words_df)[words_df$y==this_y+offset & words_df$page==this_page]))
                        this_group <- c(this_group, which(words_df$y==this_y+offset & words_df$page==this_page))
                        # print("printing this_group")
                        # print(this_group)
                }
                words_df$y[words_df$y == this_y+9 & words_df[i, ]$page == this_page] #???
                row.names(words_df)[words_df$y==193+9 & words_df$page==7] #???
                groups[this_group] <- rep(groups[i], length(this_group))
        }
        return(groups)
}

map_groups_to_numbers <- function(words_df, first_number_df, groups) {
        unique_groups <- unique(groups)
        num_groups <- rep(NA, nrow(first_number_df))
        for (i in 1:length(unique_groups)) {
                this_mean_y <- mean(words_df$y[groups==unique_groups[i]],na.rm = TRUE)
                this_page <- mean(words_df$page[groups==unique_groups[i]], na.rm = TRUE)
                #if(100 < i & i < 200) {
                #        print(paste("group:", as.character(unique_groups[i]), " page: ", as.character(this_page), " mean: ", as.character(this_mean_y), sep=""))
                #}
                this_group <- NULL
                for (offset in c(-1, -0.5, 0, 0.5, 1)) {
                        # this_group <- c(this_group, as.numeric(row.names(words_df)[words_df$y==this_y+offset & words_df$page==this_page]))
                        this_group <- c(this_group, which(first_number_df$y==this_mean_y+offset & first_number_df$page==this_page))
                        #if(100 < i & i < 200) {
                        #        print("printing this_group")
                        #        print(this_group)
                        #}
                }
                num_groups[this_group] <- rep(unique_groups[i], length(this_group))
        }
        return(num_groups)
}

build_consolidated_df <- function(words_df, first_number_df, groups, num_groups) {
        unique_groups <- unique(groups)
        consolidated_df <- data.frame()
        count = 0
        for (group in unique_groups) {
                count = count + 1
                print(paste("doing ", as.character(count)))
                        print(group)
                        #if (!is.na(group) & ( group == 192 | group == 185 | group == 186 ) ) {
                        if( (!is.na(group) & (sum(groups==group & !is.na(groups)) >0 ) & (sum(num_groups==group & !is.na(num_groups)) >0 ) ) ) {
                                
                                this_group_words <- paste(words_df$words[groups==group & !is.na(groups)], collapse="")
                                this_group_first_number <- first_number_df$first_number[num_groups==group][!is.na(first_number_df$first_number[num_groups==group])]
                                if (length(this_group_first_number) > 0) {
                                        print(this_group_words)
                                        print(this_group_first_number)
                                        this_df <- data.frame(this_group_words, this_group_first_number)
                                        consolidated_df <- rbind(consolidated_df, this_df)
                                        #consolidated_df <- this_df
                                }
                        }
                
        }
        return(consolidated_df)
}

remove_dictionary_words <- function(string_in) {
        string_vect <- tolower(str_split(string_in, " ")[[1]])
        # print(string_vect)
        string_vect_dict_removed <- string_vect[!(string_vect %in% GradyAugmented)]
        # print(string_vect_dict_removed)
        string_out <- paste(string_vect_dict_removed, collapse = " ")
        names(string_out) <- NULL
        return(string_out)
}

match_AP_suburbs <- function(consolidated_df, AP_suburbs) {
        suburbs <- list()
        for (item in consolidated_df$this_group_words) {
                detected_suburbs <- str_detect(item, AP_suburbs$name)
                if (sum(detected_suburbs)>0) {
                        suburbs <- list.append(suburbs, AP_suburbs$name[which(detected_suburbs)])
                } else {
                        suburbs <- list.append(suburbs, NA)
                }
        }
        return(suburbs)
}

if (FALSE) {
        return_list <- ingest_spending_data2()
        words_df <- return_list[[1]]
        first_number_df <- return_list[[2]]
        groups <- group_multiline_items(words_df)
        groups[nchar(words_df$words) == 0] <- NA
        num_groups <- map_groups_to_numbers(words_df, first_number_df, groups)
        words_df_with_groups <- cbind(words_df, groups)
        first_number_df_with_groups <- cbind(first_number_df, num_groups)
        consolidated_df <- build_consolidated_df(words_df, first_number_df, groups, num_groups)
        # this_group_words_dedictionaried <- vapply(consolidated_df$this_group_words, remove_dictionary_words, "")
        # names(this_group_words_dedictionaried) <- NULL
        # consolidated_df_dedictionaried  <- cbind(this_group_words_dedictionaried, consolidated_df$this_group_first_number)
        AP_suburbs <- read_csv("../scrape_AP_suburb_list/AP_suburb_list.csv")
        suburbs <- match_AP_suburbs(consolidated_df, AP_suburbs)
        unlisted_suburbs_with_qld <- paste(unlist(suburbs)[!is.na(unlist(suburbs))], ", Queensland", sep = "")
        geocodes <- geocode(unlisted_suburbs)
        ggmap(get_map(location="Queensland", source="google", maptype="roadmap", crop=FALSE, zoom=5)) + geom_point(data = geocodes, aes(x = lon, y = lat))
}