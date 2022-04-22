# Unit Testing
* TDD
* performed in memory - doesnt need acess to network & database

## Helpful links
* [hackr](https://hackr.io/blog/types-of-software-testing)
* [slideshare](https://www.slideshare.net/Bugraptors/performance-testing-1)

**What to Test**
* Application Domain - logic of application `{ payment flow, ticket purchase, notifications, etc }`
* user interface by automating unit test
  
**Dont Test**
* test generated code
* issues caught by compiler
* dependency or thirty party code
  
**Good Tests**
* Independent - not dependent on wifi, database, or each other 
* Automatic - runs automatic 
* Repeatable - consistent results 
* Readable


## User Interface testing
* entirely automate tasks to interact with app 

## Integration testing 
* combine and test together
* goes through real world scenarios of how the whole system works

**Integrating all tests**
* ui tests
* domain tests
* services tests
* database tests

## Acceptance testing
* final step 
* tests on actual hardward with actual data
* tested for acceptability 
* test to satisfy business criteria 
* testing requirments and needs
* performed by client or end user 

## Performance testing
* determing speed and effectiveness of software 
  
### Types
#### Throughput
* number of requests/ transactions processed by the application in a specified time duration

#### Response Time
* defined as the delay between the point of request and the first response

#### Tuning
* an iterative process that we use to identify and eliminate bottlenecks in the application 

#### Benchmarking
* the practice of comparing business process and performance metrics to industry bests and best practices from other companies