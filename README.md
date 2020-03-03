# Simple Rack - README

This is simple rack application: time service.
Application created for education purpose

It supports url /time with one parameter "format"
Parameter "format" must contains current time format string.
Available time formats: 
* year
* month
* day
* hour
* minute
* second

Run server example:

`$ rackup`

Query the server:

`$ curl --url "http://localhost:9292/time?format=year-month-day,hour:minute:second" -i`
