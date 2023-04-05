library SDHCommon

using FHIR version '4.0.1'

include FHIRHelpers version '4.1.000'

include FHIRCommon called FC

context Patient

define function Official(identifiers List<Identifier>):
  singleton from (identifiers I where I.use = 'official')

define function Official(names List<HumanName>):
  singleton from (names N where N.use = 'official')

define function Only(observations List<Observation>):
  singleton from observations

define function Earliest(observations List<Observation>):
  First(
    observations O
      sort by issued
  )

define function Latest(observations List<Observation>):
  Last(
    observations O
      sort by issued
  )

define function MostRecent(observations List<Observation>):
  Last(
    observations O
      sort by issued
  )

define function Lowest(observations List<Observation>):
  First(
    observations O
      sort by (value as Quantity)
  )

define function Highest(observations List<Observation>):
  Last(
    observations O
      sort by (value as Quantity)
  )


