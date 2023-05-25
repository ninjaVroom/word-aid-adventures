# Game Todos

- Splash page
- Instructions page pop-up
  - with a next button that leads to
  - enter name and select level pop-up
- Home page
  - start game
  - settings
    - change name
    - change level
      - ease
      - medium
      - difficult
    - toggle sound [on by default]
      - have about 3 songs
- Game page

## Hive Tables

1. levels
   - easy, medium, difficult

2. users
   - user id
   - user name
   - level [from levels table]
  settings
   - theme [dark/ light]
   - audio [on/ off]

3. played
   - user id [from users]
   - level [from levels table]
   - played [x x played]
  
4. scores
   - user id [from users]
   - list_chars [of type List<List<String>>]
   - wordList [List<String>]
   - score [x points]
   - time [x minutes...]
