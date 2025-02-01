// gno.land/r/foobardao
package foobardao

import (
  "gno.land/r/foodao"
  "gno.land/r/bardao"
  "gno.land/p/aggregateddao"
)

var FooBarDAO = aggregateddao.New(foodao.DAO, bardao.DAO)
