Christmas project for a membership list for all Leo-Clubs

Design Decisions:

- MongoDB as DataStore
- Rails (4) as Web-Framework

Data Modelling:

  - collections:
    - members
    - clubs
    - districts
    - multiple districts
    - committees

  entities:
    - office
      - every year a new office
      - defined at club/district/multiple-district
      - mapping to member

  office history:
    - function to parse all offices from the past:
      - get all clubs/districts/multiple from the past
      - find all offices
      - if office matches current user, write to field

  - Every year all members/clubs/disctricts/multiple-districts are cloned
  - Function to anonymize members must be provided
    - This will erase all personal information from all history of the user
    - This will NOT erase: ID, offices