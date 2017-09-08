context("Testing SED_MONTHLY_SUSCON")

test_that("SED_MONTHLY_SUSCON accepts single and multiple province arguments", {
  stns <- "08MF005"
  expect_identical(unique(SED_MONTHLY_SUSCON(STATION_NUMBER = stns, hydat_path = "H:/Hydat.sqlite3")$STATION_NUMBER), stns)
  expect_identical(length(unique(SED_MONTHLY_SUSCON(STATION_NUMBER = c("08MF005", "01AF006"), hydat_path = "H:/Hydat.sqlite3")$STATION_NUMBER)), length(c("08NM083", "08NE102")))
})


test_that("SED_MONTHLY_SUSCON accepts single and multiple province arguments", {
  expect_true(nrow(SED_MONTHLY_SUSCON(PROV_TERR_STATE_LOC = "PE", hydat_path = "H:/Hydat.sqlite3")) >= 1)
  expect_true(nrow(SED_MONTHLY_SUSCON(PROV_TERR_STATE_LOC = c("NU", "PE"), hydat_path = "H:/Hydat.sqlite3")) >= 1)
})

test_that("SED_MONTHLY_SUSCON produces an error when a province is not specified correctly", {
  expect_error(SED_MONTHLY_SUSCON(PROV_TERR_STATE_LOC = "BCD", hydat_path = "H:/Hydat.sqlite3"))
  expect_error(SED_MONTHLY_SUSCON(PROV_TERR_STATE_LOC = c("ID", "BCD"), hydat_path = "H:/Hydat.sqlite3"))
})

test_that("SED_MONTHLY_SUSCON can accept both arguments for backward compatability", {
  expect_true(nrow(SED_MONTHLY_SUSCON(PROV_TERR_STATE_LOC = "BC", STATION_NUMBER = "08MF005", hydat_path = "H:/Hydat.sqlite3")) >= 1)
})


test_that("SED_MONTHLY_SUSCON respects Year specification", {
  date_vector <- c("1980-01-01", "1990-01-01")
  temp_df <- SED_MONTHLY_SUSCON(
    PROV_TERR_STATE_LOC = "BC", hydat_path = "H:/Hydat.sqlite3",
    start_date = date_vector[1],
    end_date = date_vector[2]
  )
  expect_equal(c(min(temp_df$YEAR), max(temp_df$YEAR)), c(1980,1990))
})

test_that("When SED_MONTHLY_SUSCON is ALL there is an error", {
  expect_error(SED_MONTHLY_SUSCON(STATION_NUMBER = "ALL"))
})