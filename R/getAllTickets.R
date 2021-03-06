getAllTickets <- function(){
        curl = getCurlHandle()
        stopPaging <- FALSE
        result <- list()
        i <- 1

	## Need to page through the results since only 100 are returned at a time
        while(stopPaging == FALSE){
            result[[i]]<-getURL(paste(.ZendeskEnv$data$url, .ZendeskEnv$data$tickets, "?page=" ,i, sep=""), curl=curl, ssl.verifypeer=FALSE,
				.opts=list(userpwd=(paste(.ZendeskEnv$data$username, .ZendeskEnv$data$password, sep=":"))))    
            if(is.null(fromJSON(result[[i]])$next_page)){
                stopPaging <- TRUE
            }
            i <- i + 1
        }
	
	## Transform the JSON data to a data.frame
        json.data <- lapply(unlist(result), fromJSON)
        return(json.data)
        #pre.result <- lapply(json.data, function(x) do.call("rbind", x$tickets))
        #final.result<-do.call("rbind", pre.result)
        #tickets.df <- data.frame(final.result)
	#tickets.df <- unlistDataFrame(tickets.df)
        #return(tickets.df)
}

