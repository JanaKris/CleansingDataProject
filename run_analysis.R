

run_analysis <- function(directory) {   
     
     print("Running Analysis...")

     ########################################################################
     ### 1. Merges the training and the test sets to create one data set. ###
     ########################################################################
     
          #### Prepare TEST file ####
     
               ### Read X_test
               xtest <- read.table("./test/X_test.txt", header=FALSE, row.names = NULL)
               #nrow(xtest)
               #ncol(xtest)
               
               ## Add an ID column to xtest
               xtest$id <- c(1:nrow(xtest))
               #ncol(xtest)
               
               
               ### Read y_test
               ytest <- read.table("./test/y_test.txt", header=FALSE, row.names = NULL)
               #nrow(xtest)
               #ncol(xtest)
               names(ytest) <- "activity"    ## rename column
               ## Add an ID column to ytest
               ytest$id <- c(1:nrow(ytest))
               #ncol(ytest)
               
               
               ### Read test subjects
               subtest <- read.table("./test/subject_test.txt", header=FALSE, row.names = NULL)
               names(subtest) <- "subject"
               subtest$id <- c(1:nrow(subtest))
               
               
               ### Merge and prepare TEST file
               test_merge1 <- merge(ytest, xtest, by.x="id", by.y="id", all=TRUE)
               test_all <- merge(subtest, test_merge1, by.x="id", by.y="id", all=TRUE)
               
               ## Add a field to identify setname - Test(1) vs Train(2)
               setname <- 1
               test_all <- cbind(setname, test_all)
               
               #nrow(test_all)
               #ncol(test_all)
               #str(test_all)
               
               
          #### Prepare TRAIN file ####     
               ### Read X_train
               xtrain <- read.table("./train/X_train.txt", header=FALSE, row.names = NULL)
               #nrow(xtrain)
               #ncol(xtrain)
               
               ## Add an ID column to xtrain
               xtrain$id <- c(1:nrow(xtrain))
               #ncol(xtrain)
               
               
               ### Read y_train
               ytrain <- read.table("./train/y_train.txt", header=FALSE, row.names = NULL)
               #nrow(xtrain)
               #ncol(xtrain)
               names(ytrain) <- "activity"    ## rename column
               ## Add an ID column to ytrain
               ytrain$id <- c(1:nrow(ytrain))
               #ncol(ytrain)
               
               
               ### Read train subjects
               subtrain <- read.table("./train/subject_train.txt", header=FALSE, row.names = NULL)
               names(subtrain) <- "subject"
               subtrain$id <- c(1:nrow(subtrain))
               
               
               ### Merge and prepare train file
               train_merge1 <- merge(ytrain, xtrain, by.x="id", by.y="id", all=TRUE)
               train_all <- merge(subtrain, train_merge1, by.x="id", by.y="id", all=TRUE)
               
               ## Add a field to identify setname - Test(1) vs Train(2)
               setname <- 2
               train_all <- cbind(setname, train_all)
               
               #nrow(train_all)
               #ncol(train_all)
               #str(train_all)
               
          ## Merge Test and Train files
               all_data <- rbind(test_all, train_all)
               colnames(all_data) <- tolower(colnames(all_data))
               #str(all_data)
               #print(colnames(all_data))
     
               
               
     ##################################################################################################          
     ### 2. Extracts only the measurements on the mean and standard deviation for each measurement. ###
     ##################################################################################################
               
          ## Read Features list 
               f <- read.table("features.txt", header=FALSE, row.names = NULL)
          
               
          ## Get the col names with mean() or std()
               clist1 <- grep("mean()|std()", f$V2)
               clist2 <- clist1
               for (i in 1:length(clist1)){
                    clist2[i] <- clist1[i] + 4
               }
               
               #print(clist1)
               #print(clist2)
               
               
               ### Column List (add first 4 columnes)
               a<- c(1,2,3,4)
               clist <- c(a,clist2)
               #print(clist)
               
               
         ## Trim all-data to select mean & std columns
               ds <- all_data[,clist]
               #print(ncol(ds))
               #print(colnames(ds))
               

     #################################################################################
     ### 3. Uses descriptive activity names to name the activities in the data set ###
     #################################################################################
         
          ## Read Activity labels file
               acti <- read.table("activity_labels.txt", header=FALSE, row.names = NULL)
               colnames(acti) <- tolower(colnames(acti))
               acti$v3 <- as.character(acti$v2)
               #print(acti)
               
               #print(ds[,4])
               
          ## Replace Acitivity ID with Activity name    
               for (i in 1: nrow(ds)){
                    
                    act_id <- ds[i,4]
                    #print(act_id)
                    
                    ds[i,4] <- acti[act_id, 3]
                    #print(mylist[i])
               }
               
               #print(ds[,4])
               
               
     #############################################################################
     ### 4. Appropriately labels the data set with descriptive variable names. ###    
     #############################################################################
               
          ## Obtain column Names from the Features file
               colnames(f) <- tolower(colnames(f))
               f$v3 <- as.character(f$v2)              ## convert factor to character
               fnew <- f[clist1,]                      ## only those with mean/std
               
               #print(fnew)
               #print(str(fnew))
               
               a <- c("setname", "id", "subject", "activity")
               col_measures <- fnew$v3
               cnames <- c(a, col_measures)
               #print(cnames)
          
          ## Rename columns in ds  
               colnames(ds) <- c(cnames)
               #print(colnames(ds))
               
        
     ###########################################################          
     ### 5. Create a tidy data set with the average of       ###
     ###    each variable for each activity and each subject ###      
     ###########################################################        
               
               
           ## Create new dataset with summarized measures
               
               ds_summarize <- ds %>%
                    select (subject, activity, col_measures)  %>%
                    group_by(subject, activity) %>%
                    #summarise(mv1 = mean(v1, na.rm=TRUE))
                    summarise_all(funs(mean))
               
               
               write.table(ds_summarize, file="tidydata_summary.csv", append = FALSE, quote = TRUE, sep = " ",
                           eol = "\n", na = "NA", dec = ".", row.names = TRUE,
                           col.names = TRUE, qmethod = c("escape", "double"),
                           fileEncoding = "")
               
               #head(ds_summarize)
               print(ncol(ds_summarize))
               print(nrow(ds_summarize))
               print("Summarized Tidy Data - DONE")
               
}