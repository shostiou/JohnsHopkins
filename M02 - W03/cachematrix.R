## Put comments here that give an overall description of what your
## functions do

## Write a short comment describing this function

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

## Write a short comment describing this function

cacheSolve <- function(x, ...) {
  ## Return a matrix that is the inverse of 'x'
  m_inv <- x$getinv()
  if(!is.null(m_inv)) 
  {
    message("getting cached data")
    return(m_inv)
  }
  data <- x$get()
  m_inv <- solve(data, ...)
  x$setinv(m_inv)
  m_inv
}

