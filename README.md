
## Understand Window functions with Postgres

![forthebadge](http://forthebadge.com/images/badges/reading-6th-grade-level.svg)
#### Piotr Lewandowski, [@constjs](http://twitter.com/constjs)

----

#### Table of content

0. [Warm'up](./resources/00_warmp-up.sql)
0. [What's the syntax?](./resources/01_over.sql)
0. [Ranking functions](./resources/02_rank.sql)
0. [Windowing + bonus examples](./resources/03_windowing.sql)

### Database set-up

AdventureWorks - Sample database prepared by Microsoft for their trainings.
- [Installation for PostgreSQL](https://github.com/lorint/AdventureWorks-for-Postgres)

## Key points of window functions? 

* Aggregate function with OVER () clause
* Don't need GROUP BY
* Can access data from other rows / frames

#### Use cases
* Data manipulation
* Moving averages
* Cumulative sum
* Division of set (ranks or buckets)

## Support

PostgreSQL, MS SQL Server, Oracle, DB2, H2


#### [Why doesn't MySQL have window functions?](http://veekaybee.github.io/mysql-window-functions/)

![I don't know](https://cdn.meme.am/instances/500x/52119287.jpg)
