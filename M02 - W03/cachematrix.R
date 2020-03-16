## Johns Hopkins - Coursera R Programming
## Week 03 - Stephane's Assignment

## This function is used prepare an object which will
## be used to check if inverve was already calculated

makeCacheMatrix <- function(x = matrix())
{
   m_inv <- NULL
   set <- function(y) 
     {
      x <<- y
      m_inv <<- NULL
     }
   get <- function() x
   setinv <- function(inverse) m_inv <<- inverse
   getinv <- function() m_inv
   list(set = set, get = get,
        setinv = setinv,
        getinv = getinv)
}

## This function determines if an inversion was already
## done for a specific Matrix predefined with the previsou function
## "makeCacheMatrix"

cacheSolve <- function(x, ...) {
  ## Return a matrix that is the inverse of 'x'
  m_inv <- x$getinv()
  ## if not NULL => reading matrix inverse stored in cache
  if(!is.null(m_inv)) 
  {
    message("getting cached data")
    return(m_inv)
  }
  ## Otherwise, calculating Matrix inverse and store it in cache
  data <- x$get()
  m_inv <- solve(data, ...)
  x$setinv(m_inv)
  m_inv
}

